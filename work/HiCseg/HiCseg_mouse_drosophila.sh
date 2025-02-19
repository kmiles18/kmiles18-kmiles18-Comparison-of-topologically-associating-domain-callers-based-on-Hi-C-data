#!/bin/bash 

checkMakeDirectory(){
        echo -e "checking directory: $1"
        if [ ! -e "$1" ]; then
                echo -e "\tmakedir $1"
                mkdir -p "$1"
        fi
}
checkMakeDirectory DOMAINS

runHiCseg(){
BIN=$1
echo "Processing size ${BIN}"

list=($(seq $2 $3))
chromList=($(seq 1 19)) 
chromList[${#chromList[*]}]=X

for li in ${list[@]}; do

data=`printf "HIC%03d" $li`

mkdir -p DOMAINS/${data}

for chrom in ${chromList[@]}; do

Rscript hicseg_run_s.r -i /homeb/LiuKun/zongshu/Rao/${data}/${data}_50k_KR.chr${chrom} -o DOMAINS/${data}/${data}.${chrom}

done
done
}

runHiCseg 50000 94 98

chromList=(2L 2R 3L 3R X)
mkdir -p DOMAINS/Kc167
for chrom in ${chromList[@]}; do
Rscript hicseg_run_s.r -i  ../Kc167/replicate_10k_KR.chr${chrom} -o DOMAINS/Kc167/replicate_10k_KR.chr${chrom}
Rscript hicseg_run_s.r -i ../Kc167/primary_10k_KR.chr${chrom} -o DOMAINS/Kc167/primary_10k_KR.chr${chrom}
done
