def generate_rows(num_rows, output_file, starts=None):
    """
    Generate rows of multiple increasing 32-bit counters concatenated.
    
    :param num_rows: Number of rows to generate
    :param output_file: Output file path
    :param starts: List of starting values for each counter
    """
    if starts is None:
        starts = [0]  # default: one counter starting at 0

    counters = starts[:]  # copy so we don't mutate the original list

    with open(output_file, "w") as f:
        for _ in range(num_rows):
            # Convert each counter to 32-bit binary and concatenate
            row = "".join(format(c, "08b") for c in counters)
            f.write(row + "\n")

            # Increment all counters
            counters = [(c + len(starts)) % (2**8) for c in counters]


# -------------------------
# CONFIGURATION
# -------------------------
rows = 2048
filename = "memorycontent.mem"

# Example: three counters starting at different values
start_values = [0,1,2,3,4,5,6,7]

generate_rows(rows, filename, start_values)
print(f"Generated {rows} rows and saved to {filename}")
