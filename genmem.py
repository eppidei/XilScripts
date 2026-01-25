def generate_rows(num_rows, output_file, start1=0, start2=1):
    """Generate rows of two increasing 32-bit counters concatenated."""
    counter1 = start1
    counter2 = start2

    with open(output_file, "w") as f:
        for _ in range(num_rows):
            bin1 = format(counter1, '032b')
            bin2 = format(counter2, '032b')
            concatenated = bin1 + bin2
            f.write(concatenated + "\n")

            counter1 += 2
            counter2 += 2


# -------------------------
# CONFIGURATION
# -------------------------
rows = 2048                     # number of rows to generate
filename = "memorycontent.mem"       # output file name

generate_rows(rows, filename)
print(f"Generated {rows} rows and saved to {filename}")
