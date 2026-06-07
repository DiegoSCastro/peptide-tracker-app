# Easy Peptide Tracker — roadmap de melhorias

Status: roadmap acionável (consolidado)  
Data: 2026-06-06

Documento único que sequencia as melhorias. Amarra:
- `docs/product/simple-product-principles.md` (a régua: simples por design)
- `docs/product/competitor-gap-analysis-and-next-steps.md` (o que falta)
- `docs/product/engagement-and-monetization-strategy.md` (loops e pricing)

Régua de decisão: se a feature não ajuda a **logar**, **lembrar** ou **calcular
uma vez**, ela espera. Tom sempre educacional (ver
`docs/compliance/compliance-language-pack.md`): nunca "dose recomendada".

---

## North star

> Registrar rotinas e doses com o mínimo de taps — sem enciclopédia, sem
> dashboard pesado, sem ruído.

Simple · Private · Useful.

---

## Fase 1 — Glue (fechar a sensação de "incompleto")

Objetivo: os módulos que já existem passam a conversar, sem inflar o app.

1. **Library → Calculator**
   - `CalculatorPage` aceita pre-fill opcional (nome do composto + unidade).
   - Header de 1 linha com composto + half-life quando aberto pela Library.
2. **Calculator mais clara**
   - Live preview de concentração/volume enquanto digita.
   - Seringa visual simples + seletor 0.3 / 0.5 / 1.0 mL + "≈ X units".
   - Mantém os 3 campos atuais; sem Blend/Cycle/Cost.
3. **Detalhe da Library mais curto**
   - Acima da dobra: categoria, nome, resumo, half-life, 1º padrão reportado.
   - Demais seções em "Show more" (recolhidas).

Pronto quando: abrir um composto → "Open calculator" → ver mL/units com o nome
do composto no topo, em ≤ 3 taps, sem texto excessivo.

---

## Fase 2 — Hábito (payoff de logar, enxuto)

Objetivo: logar produz feedback imediato, sem virar dashboard.

1. **Chip de consistência na Today** (um número: streak ou adherence %).
2. Cálculo puro derivado de logs + rotinas (sem nova tabela/DB).
3. Linguagem premia a **ação de logar**, nunca resultado de saúde.

Pronto quando: após salvar um log, a Today mostra um chip de progresso simples.

---

## Fase 3 — Profundidade opcional (só se o uso pedir)

Mantém o app simples no caminho padrão; profundidade fica opt-in/Pro.

- Peso/medida simples + sparkline (segmento GLP-1).
- Site de injeção no log + dica "último site".
- (Pro, futuro) inventory de frasco, body map, curva PK, export.

Nada disso entra no caminho principal do iniciante.

---

## Catálogo da Library

- Teto de **~25 compostos** curados (GLP-1 + stacks comuns). Qualidade > volume.
- Não perseguir 100+ entradas.
- Conteúdo só em JSON local (`assets/library/compounds.json`), offline-first.

---

## Fora de escopo (adiado de propósito)

Inventory multi-frasco, body map, curvas PK, Blend/Cycle/Cost, Shop/Buy,
Compare, Courses, Q&A, 100+ peptídeos, ads agressivos.

---

## Princípios de UX (resumo)

- Verbos curtos nos botões: Log, Calculate, View history.
- Telas densas → recolher com "Show more".
- Today mostra só o que importa hoje.
- Um número de progresso, não dez gráficos.

---

## Métricas para validar antes de escalar

- D1 > 40%, D7 > 20%.
- Library → Calculator tap rate > 25% das sessões de Library.
- Calculator → Log completion > 15%.
