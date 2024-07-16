1.For Setup Create the Initial Powers of Tau File:
     snarkjs powersoftau new bn128 12 ceremony_0000.ptau -v
     snarkjs powersoftau contribute ceremony_0000.ptau ceremony_0001.ptau -v
     entropy:
     snarkjs powersoftau contribute ceremony_0001.ptau ceremony_0002.ptau -v
     entropy:
     snarkjs powersoftau verify ceremony_0002.ptau -v

2.phase2 randomness

    snarkjs powersoftau prepare phase2 ceremony_0002.ptau ceremony_final.ptau -v
    snarkjs powersoftau verify ceremony_final.ptau -v
3.compile the circuit circom
     circom circuit.circom --r1cs --wasm
4.proving key
 snarkjs groth16 setup circuit.r1cs ceremony_final.ptau setup_0000.zkey
5.Contribute Randomness:
snarkjs zkey contribute setup_0000.zkey setup_final.zkey  -v

6. verify
7. snarkjs zkey  verify circuit.r1cs ceremony_final.ptau  setup_final.zkey  -v
8. snarkjs groth16 fullprove input.json circuit_js/circuit.wasm setup_final.zkey proof.json public.json
9. 9.snarkjs zkey export solidityverifier setup_final.zkey verifier.sol

10. remix command
     snarkjs zkey export soliditycalldata public.json proof.json

    
