#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Please provide an element as an argument."
  exit 1
fi

# Define the element database (this can be extended with more elements)
declare -A elements
elements=(
  [1]="Hydrogen H nonmetal 1.008 -259.1 -252.9"
  [2]="Helium He noble gas 4.0026 -272.2 -268.9"
  # Add more elements here as needed
)

# Look for the argument in the database
element_info=""
if [[ "$1" =~ ^[0-9]+$ ]]; then
  # If input is a number (atomic number)
  element_info=${elements[$1]}
elif [[ "$1" =~ ^[A-Za-z]+$ ]]; then
  # If input is a name (string without numbers)
  for key in "${!elements[@]}"; do
    if [[ ${elements[$key]} == *"$1"* ]]; then
      element_info=${elements[$key]}
      break
    fi
  done
else
  # If input is a symbol (e.g., H)
  for key in "${!elements[@]}"; do
    if [[ ${elements[$key]} == *"$1"* ]]; then
      element_info=${elements[$key]}
      break
    fi
  done
fi

# If no match is found
if [ -z "$element_info" ]; then
  echo "I could not find that element in the database."
else
  # Output the element info in the required format
  IFS=' ' read -r name symbol type mass melting boiling <<< "$element_info"
  echo "The element with atomic number $1 is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melting celsius and a boiling point of $boiling celsius."
fi
