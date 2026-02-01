import cv2
import numpy as np

# Configurazione
INPUT_IMG = "kodim23.png"  # Assicurati sia nella stessa cartella
OUTPUT_MEM = "image_in.mem"
WIDTH = 768                # Risoluzione Kodak standard
HEIGHT = 512

def generate_correct_bayer():
    # 1. Carica l'immagine
    img = cv2.imread(INPUT_IMG)
    if img is None:
        print("Errore: Immagine non trovata.")
        return

    # 2. CORREZIONE FONDAMENTALE: Converti da BGR (OpenCV) a RGB
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    
    # Resize se necessario (per kodim23 non serve se il TB è settato giusto)
    img = cv2.resize(img, (WIDTH, HEIGHT))

    # 3. Estrai i canali (Ora R è davvero Rosso!)
    R = img[:, :, 0]
    G = img[:, :, 1]
    B = img[:, :, 2]

    # 4. Crea Bayer RGGB
    # R G
    # G B
    bayer = np.zeros((HEIGHT, WIDTH), dtype=np.uint8)
    
    # Righe Pari (0, 2...)
    bayer[0::2, 0::2] = R[0::2, 0::2] # (Pari, Pari) -> Rosso
    bayer[0::2, 1::2] = G[0::2, 1::2] # (Pari, Disp) -> Verde su riga R
    
    # Righe Dispari (1, 3...)
    bayer[1::2, 0::2] = G[1::2, 0::2] # (Disp, Pari) -> Verde su riga B
    bayer[1::2, 1::2] = B[1::2, 1::2] # (Disp, Disp) -> Blu

    # 5. Scrivi il file .mem
    with open(OUTPUT_MEM, 'w') as f:
        for val in bayer.flatten():
            f.write(f"{val:02x}\n")
            
    print(f"Generato {OUTPUT_MEM} (RGB Corrected).")

if __name__ == "__main__":
    generate_correct_bayer()