from PIL import Image
import math

def next_power_of_2(x):
    return 1 if x == 0 else 1 << (x - 1).bit_length()

def generate_pow2_mem(input_path, output_file, target_w, target_h):
    # --- COSTANTI DI SISTEMA ---
    STRIDE_PIXELS = 2048
    PIXELS_PER_WORD = 8   # 64 bit / 8 bit
    STRIDE_WORDS = STRIDE_PIXELS // PIXELS_PER_WORD # 256 words
    
    # Pattern di padding per l'area vuota finale (64 bit)
    # Convertiamo il pattern hex in una stringa binaria a 64 caratteri
    EOF_PAD_PATTERN = format(0xdeadbeeff1caf1ca, '064b')

    # --- 1. ELABORAZIONE IMMAGINE ---
    try:
        img = Image.open(input_path).convert('L') # 8-bit Grayscale
    except FileNotFoundError:
        print(f"Errore: File {input_path} non trovato.")
        return

    # Ridimensiona
    if target_w > STRIDE_PIXELS:
        print(f"Errore: Larghezza {target_w} > Stride {STRIDE_PIXELS}")
        return
    img = img.resize((target_w, target_h), Image.Resampling.LANCZOS)
    pixels = img.load()

    # --- 2. CALCOLO DIMENSIONI MEMORIA ---
    # Spazio occupato dall'immagine + padding di riga
    used_words = target_h * STRIDE_WORDS
    
    # Calcolo la dimensione totale (potenza di 2)
    total_mem_size = next_power_of_2(used_words)
    
    print(f"--- Statistiche Memoria ---")
    print(f"Risoluzione: {target_w}x{target_h}")
    print(f"Word utilizzate (Img + Stride): {used_words}")
    print(f"Dimensione Totale File (Pow2):  {total_mem_size}")
    print(f"Padding finale (DeadBeef):      {total_mem_size - used_words} words")

    # --- 3. SCRITTURA FILE ---
    with open(output_file, 'w') as f:
        # A. Scrittura Immagine + Padding di Riga (0)
        for y in range(target_h):
            for w in range(STRIDE_WORDS):
                word_bits = ""
                for p in range(PIXELS_PER_WORD):
                    curr_x = w * PIXELS_PER_WORD + p
                    
                    if curr_x < target_w:
                        val = pixels[curr_x, y]
                    else:
                        val = 0 # Padding di riga (rimane 0)
                    
                    word_bits += format(val, '08b')
                
                f.write(word_bits + '\n')
        
        # B. Scrittura Padding Finale (DEADBEEF...) fino a Pow2
        padding_needed = total_mem_size - used_words
        for _ in range(padding_needed):
            f.write(EOF_PAD_PATTERN + '\n')

    print(f"File '{output_file}' generato con successo.")

# --- UTILIZZO ---
# Esempio: Immagine ridimensionata a 1280x720
# Word usate: 720 righe * 256 words = 184.320 words
# Potenza di 2 successiva: 2^18 = 262.144 words
generate_pow2_mem("kodim23.png", "mem_pow2.bin", 120, 80)