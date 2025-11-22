<img src="C:\Users\Cyinc\AppData\Roaming\Typora\typora-user-images\image-20250925174654961.png" alt="image-20250925174654961" style="zoom:67%;" />

# State Test for SKINNY

## 规则：

1. 只能 test 固定差分（0差分），如 tested cell is Tcell；【如果 test 截断差分，则需要 test 4 次（我的理解）】
2. 要求被消除的密钥
   1. 仅涉及 Tcell 的计算（涉及的其他地+方不用计算）
   2. 加在固定差分（0差分）

# SKINNY-64-192

这个区分器概率为 $2^{-57.56}$

<img src="C:\Users\Cyinc\AppData\Roaming\Typora\typora-user-images\image-20250922225151755.png" alt="image-20250922225151755" style="zoom: 67%;" />



## 区分器详情：

<img src="C:\Users\Cyinc\AppData\Roaming\Typora\typora-user-images\image-20250922233219589.png" alt="image-20250922233219589" style="zoom:67%;" />

<img src="C:\Users\Cyinc\AppData\Roaming\Typora\typora-user-images\image-20250923174927380.png" alt="image-20250923174927380" style="zoom: 50%;" />

**限制第 6 轮输入 + 密钥差分 + 密钥不允许在 Eb 中抵消**



<img src="C:\Users\Cyinc\AppData\Roaming\Typora\typora-user-images\image-20250922225302730.png" alt="image-20250922225302730" style="zoom: 50%;" />

---

<img src="C:\Users\Cyinc\AppData\Roaming\Typora\typora-user-images\image-20250923173643666.png" alt="image-20250923173643666" style="zoom:67%;" />





# New functions (supplements)









