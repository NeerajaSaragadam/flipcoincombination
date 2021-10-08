print_winner ()
{
    
local -n keys=$1
local -n values=$2

max_value=0
max_value_index=0
for(( i = 0; i < ${#values[@]}; i++ ))
do
if(( values[i] >= max_value ))
then    
max_value=${values[i]}
max_value_index=$i
fi
done
echo "The winning combination is ${keys[$max_value_index]} with ${max_value}%" 
}

read -p "Enter number of times to flip a combination:" no_of_flips

echo 
echo "SINGLET-COMBINATION"
declare -A singlet_frequency=( 

                                [H]=0
                                [T]=0

                              )
for(( flip = 1; flip <= no_of_flips; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin = RANDOM % 2 ))
    case $coin in 
        0)
            echo "Heads"
            (( singlet_frequency[H]++ ))
            ;;
        1)
            echo "Tails"
            (( singlet_frequency[T]++ ))
    esac
done

for combination in ${!singlet_frequency[@]}
do
    percentage=$(( ${singlet_frequency[$combination]}  * 100 / no_of_flips ))
    singlet_frequency[$combination]=$percentage
    echo "percentage of $combination is ${singlet_frequency[$combination]}%"   
done

echo "DOUBLET-COMBINATION"
declare -A doublet_frequency=( 

                                [HH]=0
                                [HT]=0
                                [TH]=0
                                [TT]=0

                              )

for(( flip = 1; flip <= no_of_flips; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_1 = RANDOM % 2 ))
    (( coin_2 = RANDOM % 2 ))

    case $coin_1$coin_2 in 
        00)
            echo "Heads Heads"
            (( doublet_frequency[HH]++ )) 
            ;;
        01)
            echo "Heads Tails"
            (( doublet_frequency[HT]++ ))
            ;;
        10)
            echo "Tails Heads"
            (( doublet_frequency[TH]++ ))
            ;;
        11)
            echo "Tails Tails"
            (( doublet_frequency[TT]++ ))
            ;;
    esac
done

for combination in ${!doublet_frequency[@]}
do
    percentage=$(( ${doublet_frequency[$combination]}  * 100 / no_of_flips ))
    doublet_frequency[$combination]=$percentage
    echo "percentage of $combination is ${doublet_frequency[$combination]}%"   
done

echo "TRIPLET-COMBINATION"
declare -A triplet_frequency=( 
                                    [HHH]=0
                                    [HHT]=0
                                    [HTH]=0
                                    [HTT]=0
                                    [THH]=0
                                    [THT]=0
                                    [TTH]=0
                                    [TTT]=0
                            
                                )
for(( flip = 1; flip <= no_of_flips; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_1 = RANDOM % 2 ))
    (( coin_2 = RANDOM % 2 ))
    (( coin_3 = RANDOM % 2 ))

    case $coin_1$coin_2$coin_3 in 
        000)
            echo "Heads Heads Heads"
            (( triplet_frequency[HHH]++ )) 
            ;;
        001)
            echo "Heads Heads Tails"
            (( triplet_frequency[HHT]++ ))
            ;;
        010)
            echo "Heads Tails Heads"
            (( triplet_frequency[HTH]++ ))
            ;;
        011)
            echo "Heads Tails Tails"
            (( triplet_frequency[HTT]++ ))
            ;;
        100)
            echo "Tails Heads Heads"
            (( triplet_frequency[THH]++ )) 
            ;;
        101)
            echo "Tails Heads Tails"
            (( triplet_frequency[THT]++ ))
            ;;
        110)
            echo "Tails Tails Heads"
            (( triplet_frequency[TTH]++ ))
            ;;
        111)
           echo "Tails Tails Tails"
            (( triplet_frequency[TTT]++ ))
            ;;
    esac
done
for combination in ${!triplet_frequency[@]}
do
    percentage=$(( ${triplet_frequency[$combination]}  * 100 / no_of_flips ))
    triplet_frequency[$combination]=$percentage
    echo "percentage of $combination is ${triplet_frequency[$combination]}%"   
done

singlet_combinations=( ${!singlet_frequency[@]} )
singlet_combination_percentages=( ${singlet_frequency[@]} )

doublet_combinations=( ${!doublet_frequency[@]} )
doublet_combination_percentages=( ${doublet_frequency[@]} )

triplet_combinations=( ${!triplet_frequency[@]} )
triplet_combination_percentages=( ${triplet_frequency[@]} )

total_combinations+=( ${singlet_combinations[@]} ${doublet_combinations[@]} ${triplet_combinations[@]} )
total_combination_percentages+=( ${singlet_combination_percentages[@]} ${doublet_combination_percentages[@]} ${triplet_combination_percentages[@]} )



echo "SORTING"
echo  "sorted singlet percentages:"
echo "$( printf "%s\n" "${singlet_combination_percentages[@]}" | sort -n ) "

echo  "sorted doublet percentages:"
echo "$( printf "%s\n" "${doublet_combination_percentages[@]}" | sort -n ) "

echo  "sorted triplet percentages:"
echo "$( printf "%s\n" "${triplet_combination_percentages[@]}" | sort -n ) "

echo "WINNERS"
echo "For Singlet Combination"
print_winner singlet_combinations singlet_combination_percentages
echo 
echo "For Doublet Combination"
print_winner doublet_combinations doublet_combination_percentages
echo

echo "For Triplet Combination"
print_winner triplet_combinations triplet_combination_percentages
echo

echo "For All Combinations"
print_winner total_combinations total_combination_percentages