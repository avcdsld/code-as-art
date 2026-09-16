class φ:
    pass

class λ:
    def __call__(self, *ψ):
        return ψ[0] if ψ else self

def δ(α, β):
    return (α, β)

ψ = λ()
χ = δ(φ, ψ)

Ω = [ψ, χ]

for ε in Ω:
    ε()
