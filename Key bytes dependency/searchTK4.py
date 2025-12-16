import subprocess
import os

# 创建 solutions 目录（如果不存在）
os.makedirs('.\\solution\\', exist_ok=True)

for i in range(150, 200):
    for j in range(1, 256):
        cmd = f'minizinc --solver Gecode -D fx1={i} -D fx2={j} _v_16r_TK4.mzn'
        result = subprocess.run(cmd, shell=True, 
                              stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT,
                              text=True)
        
        full_output = result.stdout
        
        if "UNSATISFIABLE" in full_output:
            print(f"fx=({i},{j}): UNSAT")
        else:
            print(f"fx=({i},{j}): SAT")
            with open(f'.\\solution\\solution_{i}_{j}.txt', 'w') as f:
                f.write(full_output)