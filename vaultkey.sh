#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Vault Key ASCII Art Banner with color
echo -e "${CYAN} _     __          _ _     _  __           ${NC}"
echo -e "${CYAN} \ \   / /_ _ _   _| | |_  | |/ /___ _   _ ${NC}"
echo -e "${CYAN}  \ \ / / _\` | | | | | __| | ' // _ \\ | | |${NC}"
echo -e "${CYAN}   \ V / (_| | |_| | | |_  | . \\  __/ |_| |${NC}"
echo -e "${CYAN}    \_/ \__,_|\__,_|_|\__| |_|\_\\___|\__, |${NC}"
echo -e "${CYAN}                                     |___/ ${NC}"
echo
echo -e "${BLUE}VaultKey is a bash script used to generate secure passwords."
echo
echo -e "${BLUE}Created By : Souvik Das (https://www.github.com/s0uvik-das)"

echo;echo
echo -e "${GREEN}   1. Generate a Strong Password${NC}"
echo -e "${GREEN}   2. Check Your Password Strength${NC}"
echo -e "${GREEN}   3. Tips for write a strong password${NC}"
echo
echo -e -n "${GREEN}   Select one option : ${NC}"
read choice

#Function to generate strong password
function generate_password () {
    echo -e -n "${GREEN}   Enter password length : ${NC}"
    read length

    echo

    if (( $length < 12 )); then
    
        echo -e "${RED}   WARNING: Choose a password length of 12 or more for better strong password. ${NC}"
        echo

        local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-={}[]|\:;'<>,.?/"  # All possible characters
        local password=()  # Array to store characters of the password

        # Add at least one of each required character type
        password+=(${chars:$((RANDOM % 26)):1})  # Add random uppercase letter
        password+=(${chars:$((RANDOM % 26 + 26)):1})  # Add random lowercase letter
        password+=(${chars:$((RANDOM % 10 + 52)):1})  # Add random digit
        password+=(${chars:$((RANDOM % 27 + 62)):1})  # Add random special character

        # Add remaining characters to meet length requirement
        for (( i=${#password[@]}; i<length; i++ )); do
            password+=(${chars:$((RANDOM % ${#chars})):1})
        done

        # Shuffle the password characters randomly
        shuf <<< "$(printf "%s" "${password[@]}")" | tr -d '\n'
            
    else
        local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-={}[]|\:;'<>,.?/"  # All possible characters
        local password=()  # Array to store characters of the password

        # Add at least one of each required character type
        password+=(${chars:$((RANDOM % 26)):1})  # Add random uppercase letter
        password+=(${chars:$((RANDOM % 26 + 26)):1})  # Add random lowercase letter
        password+=(${chars:$((RANDOM % 10 + 52)):1})  # Add random digit
        password+=(${chars:$((RANDOM % 27 + 62)):1})  # Add random special character

        # Add remaining characters to meet length requirement
        for (( i=${#password[@]}; i<length; i++ )); do
            password+=(${chars:$((RANDOM % ${#chars})):1})
        done

        # Shuffle the password characters randomly
        shuf <<< "$(printf "%s" "${password[@]}")" | tr -d '\n'
            
    fi
    
}

#function to check password strength
function password_strength_check () {
    echo -e -n "${GREEN}   Enter your password: ${NC}"
    read  user_password
    echo

    special_chars=("!" "@" "#" "$" "%" "^" "&" "*" "(" ")" "_" "+" "=" "-" "{" "[" "]" "|" "\\" "/" ":" ";" "'" "<" ">" "," "." "?")

    local uppercase_count=$(echo "$user_password" | grep -o '[A-Z]' | wc -l)
    local lowercase_count=$(echo "$user_password" | grep -o '[a-z]' | wc -l)
    local digit_count=$(echo "$user_password" | grep -o '[0-9]' | wc -l)
    local special_char_count=0

    for char in "${special_chars[@]}"; do
        count=$(echo "$user_password" | grep -F -o "$char" | wc -l)
        special_char_count=$((special_char_count + count))
    done

    local is_secure=true
    local message=""

    if (( ${#user_password} < 12 )); then
        is_secure=false
        message+="\n   - Password should be at least 12 characters long."
    fi
    if (( uppercase_count < 1 )); then
        is_secure=false
        message+="\n   - Password should contain at least one uppercase letter."
    fi
    if (( lowercase_count < 1 )); then
        is_secure=false
        message+="\n   - Password should contain at least one lowercase letter."
    fi
    if (( digit_count < 1 )); then
        is_secure=false
        message+="\n   - Password should contain at least one digit."
    fi
    if (( special_char_count < 1 )); then
        is_secure=false
        message+="\n   - Password should contain at least one special character."
    fi

    if [ "$is_secure" = true ]; then
        echo -e "${CYAN}   Congratulations... your password is secure.${NC}"
    else
        echo -e "${RED}   Sorry... your password is not secure.${NC}${message}"
    fi
}
#advice of secure password 
function secure_password_tips () {
    #sleep command to make an animation
    echo -e "${PURPLE}    1. Password at least 12 characters long."
    sleep .05s
    
    echo -e "${PURPLE}    2. Include a mix of uppercase letters, lowercase letters, numbers, and special characters (like !, @, #, $, %, etc.)."
    sleep .05s

    echo -e "${PURPLE}    3. Avoid using easily guessable words, phrases, or patterns (like 'password', '123456', 'qwerty', etc.)."
    sleep .05s

    echo -e "${PURPLE}    4. Avoid using easily guessable information such as birthdays, names of family members, or favorite sports teams."
    sleep .05s

    echo -e "${PURPLE}    5. Use different passwords for different accounts."
    sleep .05s

    echo -e "${PURPLE}    6. Hackers often use dictionary attacks that try every word in the dictionary. Avoid using recognizable words in any language."
    sleep .05s

    echo -e "${PURPLE}    7. Regularly change your passwords, especially for sensitive accounts or if you suspect they may have been compromised."
    sleep .05s

    echo -e "${PURPLE}    8. Enable two-factor authentication for an added layer of security."
    sleep .05s

}

#check user choice
if (( choice == 1 )); then
    generate_password
elif (( choice == 2 )); then
    password_strength_check
elif (( choice == 3 )); then
    secure_password_tips
else
    echo
    echo -e "${RED}   Invalid option. Please select either 1, 2 or 3.${NC}"
fi
