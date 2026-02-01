import cv2
import numpy as np

# Configuration
INPUT_IMG = "kodim23.png"      # Put your source image here
MEM_FILE  = "image_in.mem"  # File for Verilog to read
WIDTH     = 768             # Resize to this for simulation speed
HEIGHT    = 512

def create_bayer_hex():
    # 1. Load Image
    img = cv2.imread(INPUT_IMG)
    if img is None:
        print("Error: Image not found.")
        return

    # Resize for simulation
  #  img = cv2.resize(img, (WIDTH, HEIGHT))
    
    # 2. Simulate Bayer Mosaic (RGGB Pattern)
    # R G
    # G B
    bayer = np.zeros((HEIGHT, WIDTH), dtype=np.uint8)
    
    # Extract channels (OpenCV is BGR)
    B, G, R = cv2.split(img)

    # RGGB Logic:
    # Even Row, Even Col = R
    # Even Row, Odd Col  = G
    # Odd Row,  Even Col = G
    # Odd Row,  Odd Col  = B
    
    bayer[0::2, 0::2] = R[0::2, 0::2] # R
    bayer[0::2, 1::2] = G[0::2, 1::2] # G
    bayer[1::2, 0::2] = G[1::2, 0::2] # G
    bayer[1::2, 1::2] = B[1::2, 1::2] # B

    # 3. Write to Hex File
    # Verilog $readmemh expects hex values separated by whitespace
    with open(MEM_FILE, 'w') as f:
        for val in bayer.flatten():
            f.write(f"{val:02x}\n")
            
    print(f"Generated {MEM_FILE} with resolution {WIDTH}x{HEIGHT}")

if __name__ == "__main__":
    create_bayer_hex()