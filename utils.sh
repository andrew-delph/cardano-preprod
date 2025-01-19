#!/bin/bash

# Function to convert ADA to Lovelace
ada_to_lovelace() {
    local ada=$1
    if [[ ! "$ada" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: Input must be a valid number"
        return 1
    fi
    local lovelace=$(echo "$ada * 1000000" | bc)
    echo "$lovelace"
}

# Function to convert Lovelace to ADA
lovelace_to_ada() {
    local lovelace=$1
    if [[ ! "$lovelace" =~ ^[0-9]+$ ]]; then
        echo "Error: Input must be a valid integer"
        return 1
    fi
    local ada=$(echo "scale=6; $lovelace / 1000000" | bc)
    echo "$ada"
}

# # Example usage:
# # Convert 2.5 ADA to Lovelace
# echo "2.5 ADA in Lovelace: $(ada_to_lovelace 2.5)"

# # Convert 2500000 Lovelace to ADA
# echo "2500000 Lovelace in ADA: $(lovelace_to_ada 2500000)"
