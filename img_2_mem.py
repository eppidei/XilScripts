import cv2
import numpy as np
import sys

# ================= CONFIGURAZIONE UTENTE =================

INPUT_IMAGE  = "kodim23.png" 
OUTPUT_MEM   = "image.mem"

# Scegli la modalità: 'BAYER' o 'RGB'
MODE = 'BAYER' 

# Configurazione Hardware
DATA_WIDTH   = 64      # Larghezza bus DDR (bit)
STRIDE_BYTES = 4096    # Spazio allocato per ogni riga in BYTES

# Configurazione Bayer (Solo se MODE = 'BAYER')
# Pattern comuni: 'BGGR', 'GBRG', 'GRBG', 'RGGB'
BAYER_PATTERN = 'BGGR' 

# Configurazione RGB (Solo se MODE = 'RGB')
# True = 32 bit per pixel (B,G,R,0). False = 24 bit (B,G,R)
# AXI Video di solito usa 32 bit per allineamento.
USE_32BIT_RGB = True   

# Valore di padding per lo spazio vuoto (stride)
PADDING_VAL  = 0x00 

# =========================================================

def create_bayer_image(img, pattern):
    """Simula un sensore Raw Bayer campionando l'immagine RGB"""
    height, width, _ = img.shape
    
    # Crea immagine a singolo canale
    bayer = np.zeros((height, width), dtype=np.uint8)
    
    # Estrai i canali (OpenCV usa BGR)
    B = img[:, :, 0]
    G = img[:, :, 1]
    R = img[:, :, 2]
    
    # Applica il campionamento in base al pattern (Vettorizzato con NumPy)
    if pattern == 'BGGR':
        # Riga Pari: B G B G
        bayer[0::2, 0::2] = B[0::2, 0::2] # Even Row, Even Col = Blue
        bayer[0::2, 1::2] = G[0::2, 1::2] # Even Row, Odd Col  = Green
        # Riga Dispari: G R G R
        bayer[1::2, 0::2] = G[1::2, 0::2] # Odd Row, Even Col  = Green
        bayer[1::2, 1::2] = R[1::2, 1::2] # Odd Row, Odd Col  = Red
        
    elif pattern == 'RGGB':
        bayer[0::2, 0::2] = R[0::2, 0::2]
        bayer[0::2, 1::2] = G[0::2, 1::2]
        bayer[1::2, 0::2] = G[1::2, 0::2]
        bayer[1::2, 1::2] = B[1::2, 1::2]

    elif pattern == 'GBRG':
        bayer[0::2, 0::2] = G[0::2, 0::2]
        bayer[0::2, 1::2] = B[0::2, 1::2]
        bayer[1::2, 0::2] = R[1::2, 0::2]
        bayer[1::2, 1::2] = G[1::2, 1::2]

    elif pattern == 'GRBG':
        bayer[0::2, 0::2] = G[0::2, 0::2]
        bayer[0::2, 1::2] = R[0::2, 1::2]
        bayer[1::2, 0::2] = B[1::2, 0::2]
        bayer[1::2, 1::2] = G[1::2, 1::2]
        
    else:
        print(f"Pattern {pattern} non supportato. Uso BGGR.")
        return create_bayer_image(img, 'BGGR')
        
    return bayer

def main():
    # 1. Carica immagine
    img_orig = cv2.imread(INPUT_IMAGE) # Carica BGR
    
    if img_orig is None:
        print(f"Errore: Impossibile aprire {INPUT_IMAGE}")
        return

    height, width, _ = img_orig.shape
    print(f"Immagine input: {width}x{height}, Modalità: {MODE}")

    # 2. Prepara i dati della riga (Row Bytes)
    pixel_data = None
    
    if MODE == 'BAYER':
        print(f"Generazione pattern Bayer: {BAYER_PATTERN}")
        bayer_img = create_bayer_image(img_orig, BAYER_PATTERN)
        pixel_data = bayer_img # Già uint8 (H, W)
        
    elif MODE == 'RGB':
        if USE_32BIT_RGB:
            print("Formato: 32-bit Packed (BGRA)")
            # Aggiunge canale Alpha vuoto per fare 4 byte
            img_rgba = cv2.cvtColor(img_orig, cv2.COLOR_BGR2BGRA) 
            pixel_data = img_rgba # (H, W, 4)
        else:
            print("Formato: 24-bit Packed (BGR)")
            pixel_data = img_orig # (H, W, 3)
            
    # 3. Scrittura File Memoria
    bytes_per_word = DATA_WIDTH // 8
    total_words = 0

    # Calcola larghezza effettiva in byte della parte immagine
    if MODE == 'BAYER':
        img_row_bytes = width * 1 # 1 byte per pixel
    elif MODE == 'RGB':
        if USE_32BIT_RGB: img_row_bytes = width * 4
        else: img_row_bytes = width * 3

    # Check Stride
    if img_row_bytes > STRIDE_BYTES:
        print(f"ERRORE CRITICO: La riga immagine ({img_row_bytes} byte) è più larga dello Stride ({STRIDE_BYTES} byte)!")
        print("Aumenta STRIDE_BYTES o riduci la risoluzione.")
        return

    pad_len = STRIDE_BYTES - img_row_bytes
    print(f"Bytes immagine per riga: {img_row_bytes}")
    print(f"Bytes padding per riga:  {pad_len}")

    with open(OUTPUT_MEM, "w") as f:
        for r in range(height):
            # Ottieni i byte grezzi della riga
            row_raw = pixel_data[r, :] # Questo può essere (W) o (W, 3) o (W, 4)
            row_bytes = row_raw.flatten() # Appiattisce in array monodimensionale di byte
            
            # Crea Padding
            padding = np.full(pad_len, PADDING_VAL, dtype=np.uint8)
            
            # Concatena
            full_row_bytes = np.concatenate((row_bytes, padding))
            
            # Raggruppa in parole (Words)
            # Reshape in (Num_Words, 8) per 64-bit
            words = full_row_bytes.reshape(-1, bytes_per_word)
            
            for word in words:
                # Scrittura Hex Little Endian (Byte più basso a destra nel file Hex? 
                # Dipende da come $readmemh carica. 
                # Di solito per vedere 'ABCD' in memoria:
                # byte[0]=D, byte[1]=C... quindi reversed.
                hex_str = ""
                for b in reversed(word):
                    hex_str += f"{b:02X}"
                f.write(hex_str + "\n")
                total_words += 1

    print(f"Successo. Generato {OUTPUT_MEM} con {total_words} parole.")

if __name__ == "__main__":
    main()