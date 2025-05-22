# 📊 Probability: Binomial vs Bernoulli and Probability Mass Function

---

## 1. Binomial vs Bernoulli Distribution

| Feature          | **Bernoulli Distribution**                  | **Binomial Distribution**                                |
|------------------|---------------------------------------------|-----------------------------------------------------------|
| Definition       | 1 trial with 2 outcomes                     | Number of successes in `n` trials                         |
| Trials           | 1                                           | `n ≥ 1`                                                   |
| Support          | `X ∈ {0, 1}`                                | `X ∈ {0, 1, ..., n}`                                      |
| Parameters       | `p`                                         | `n, p`                                                    |
| Mean             | `μ = p`                                     | `μ = np`                                                  |
| Variance         | `σ² = p(1 - p)`                             | `σ² = np(1 - p)`                                          |
| Use Case         | Single coin flip                            | Multiple coin flips, or repeated independent experiments  |

---

## 2. What is a Probability Mass Function (PMF)?

A **Probability Mass Function (PMF)** gives the probability that a **discrete random variable** is equal to a specific value.

### Properties:
- `P(X = xᵢ) ≥ 0`
- `Σ P(X = xᵢ) = 1` over all possible values of `xᵢ`

---

## 3. PMF Use Cases and Examples

---

### ✅ Example 1: Product Defects (Binomial Distribution)

**Scenario**: A factory has a defect rate of 5%. What’s the probability of exactly 2 defective items in a batch of 10?

- Parameters:
  - `n = 10`
  - `p = 0.05`
  - `X ~ Binomial(10, 0.05)`

**PMF Formula**:
