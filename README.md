# Disjunctive Normal Unsupervised LDA Classifier for P300 
This repository includes different versions of DNUL classifier and tested with a synthetic data.

## Instructions

To run the code:

1. `clone` this repository to your computer or you can download the files by [clicking here](https://github.com/MajedElwardy/DNUL_Classifier/archive/master.zip).
1. Run the `Demo_Run.m` and do not forget to add to path: `DNUL_utilities` folder.
1. Have fun.

## DNUL versions
We have 3 version implementations of the DNUL energy function. 

### DNUL V.1
![DNUL1](https://latex.codecogs.com/gif.latex?%7BE%7D%28x%29%20%3D%20%5Csum_%7Bi%7D%5E%7BM%7D%5CBigg%28%201%20-%20%5Cprod_%7Bj%7D%5E%7Bn%7D%5Cbigg%28%5Cunderbrace%7B1-%20f%28x_%7Bji%7D%29%20%5Cprod_%7Bk%20%5Cneq%20j%7D%5E%7Bn%7D%20%5CBig%281-f%28x_%7Bki%7D%29%5CBig%29%7D_%7BQ_j%7D%20%5Cbigg%29%5CBigg%29)

This is our first implementation of the DNUL classifier.
### DNUL V.2
![DNUL2](https://latex.codecogs.com/gif.latex?%7B%5Ccal%20L%7D%28%5CTheta%29%20%3D%20%5Csum_%7Bi%7D%5E%7Bm%7D%20%5Csum_%7Bj%7D%5E%7Bn%7D%5Cbigg%28%5Cunderbrace%7Bf_%7B%5CTheta%7D%28x_%7Bij%7D%29%20%5Cprod_%7Bk%20%5Cneq%20j%7D%5E%7Bn%7D%20%5CBig%281-f_%7B%5CTheta%7D%28x_%7Bik%7D%29%5CBig%29%7D_%7BQ_j%7D%20%5Cbigg%29)

This one exactly same as the first version. This version if more stable and faster than the first version.
### DNUL V.3
![DNUL3](https://latex.codecogs.com/gif.latex?%7B%5Ccal%20L%7D%28%5CTheta%29%20%3D%20%5Csum_%7Bi%7D%5E%7Bm%7D%20%5Csum_%7Bj%7D%5E%7Bn%7D%20%5Cprod_%7Br%7D%5E%7BR%7D%5Cbigg%28%5Cunderbrace%7Bf_%7B%5CTheta%7D%28x_%7Bijr%7D%29%20%5Cprod_%7Bk%20%5Cneq%20j%7D%5E%7Bn%7D%20%5CBig%281-f_%7B%5CTheta%7D%28x_%7Bikr%7D%29%5CBig%29%7D_%7BQ_j%7D%20%5Cbigg%29)

Note: This version is not finalised yet. It works perfect up to 7 repetitions. Once you increase the number of trials, it gives 0. (Still working on that).
