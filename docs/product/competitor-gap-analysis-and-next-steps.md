# Análise do concorrente + próximos passos para competir minimamente

Status: input de produto  
Data: 2026-06-06  
Contexto: capturas de um app concorrente (Calculator + School/Library + Inventory +
Tracker + Shop), sem ads visíveis. Comparado ao estado atual deste projeto após
Fase 0 (design Vital Glass), Library v1 (13 compostos) e MVP de logging.

Este documento **não** muda a postura de compliance em
`docs/compliance/compliance-language-pack.md`. O objetivo é competir em
**utilidade e polish**, não em claims médicos ou sourcing.

> **Atualização (2026-06-06):** o produto adota posição **simples por design**
> — ver `docs/product/simple-product-principles.md`. Não vamos replicar a
> amplitude do concorrente; priorizamos fluxo enxuto e nome **Easy Peptide
> Tracker**.

---

## 1. O que o concorrente faz bem (pontos positivos)

### 1.1 Produto integrado de ponta a ponta

O fluxo é contínuo, não fragmentado:

```
Library (School) → Calculator (com peptide pré-selecionado) → Inventory → Tracker
```

No nosso app hoje, Library, Calculator e Protocols/Log existem, mas **não
conversam**. O usuário copia números na mão. O concorrente elimina essa fricção —
e isso é a maior diferença percebida de “app completo” vs “app incompleto”.

### 1.2 Calculator como experiência, não como fórmula

| Elemento | Concorrente | Nosso app hoje |
|---|---|---|
| Wizard em passos (Step 1–4) | Sim | Não — tela única |
| Selecionar peptide da Library | Sim | Não |
| Live preview (“2.0 mg = 0.80 mL”) | Sim | Só após calcular |
| Visual de seringa + unidades | Sim | Não |
| Tamanho de seringa (0.3 / 0.5 / 1.0 mL) | Sim | Não |
| Validação amigável (“Dosing looks good”) | Sim | Não |
| Modos: Single / Blend / Cycle / Cost | Sim | Só single |
| Salvar resultado / recipe | Sim | Não |

Isso transforma a calculadora de “ferramenta que uso uma vez” em “ferramenta que
abro toda reconstituição”.

### 1.3 Library como produto principal, não como extra

- **104 peptídeos** vs nossos **13** — escala de catálogo incomparável hoje.
- Cards ricos: tags (Fat Loss, Longevity, FDA-approved), mecanismo, half-life, MW.
- Sort + Filters + favoritos + comparar.
- Detalhe profundo: Key Facts, Protocol (dose range, frequency, cycle, route),
  accordions (Science, Benefits, Side Effects, Stacking, References).
- CTA direto: **Calculate Dose** — liga conteúdo à ação.

Nossa Library v1 já tem a **estrutura certa** (padrões reportados + fontes +
compliance), mas falta profundidade, volume e ligação com Calculator.

### 1.4 Inventory (estoque de frascos)

O concorrente trata o frasco como objeto de primeira classe:

- Total / remaining, unidade (mg / mcg / IU)
- Frasco reconstituído ou não
- Concentração (mg/mL) → desconto automático no log
- Lote, validade, notas
- Fluxo “Select from Library” que puxa defaults (half-life, dose típica)

Nós **não temos inventory**. Para usuários research/TRT (segmento de maior LTV),
isso sozinho justifica pagar por um app.

### 1.5 Polish de UX

- Step badges (STEP 1, STEP 2…) guiam tarefas complexas.
- Segmented controls (mg/mcg/IU, Single/Blend/Cycle/Cost).
- Feedback positivo imediato na revisão de dose.
- Cards com hierarquia clara; bottom nav com 5 áreas bem nomeadas.

O redesign Vital Glass melhorou nosso visual, mas a **densidade de utilidade por
tela** ainda está atrás.

### 1.6 Modelo sem ads (percebido)

Sem banners, o app parece premium/confiável. Monetização provável via
**assinatura** e/ou **affiliate (“Buy”)** — alinhado com nossa conclusão de que
este nicho é subscription-led, não ads-led
(`docs/product/engagement-and-monetization-strategy.md`).

---

## 2. Pontos negativos e riscos do concorrente

### 2.1 Compliance e claims

- Seções **Benefits**, **“Dosing looks good”**, **“expected ranges”** podem
  implicar que o app **valida ou endossa** doses — exatamente o que nosso
  `compliance-language-pack` proíbe.
- Disclaimer “For research use only” ao lado de protocolos detalhados é
  **contraditório**; reguladores e stores podem questionar.
- **“Ask about this peptide” / Q&A** pode virar canal de conselho médico não
  moderado.
- Tags de marketing (“Fat Loss”, “Longevity”) sem contexto podem ser lidas como
  promessa de resultado.

**Nossa vantagem defensável:** framing educacional + padrões *atribuídos* +
disclaimer consistente. Não copiar o tom “otimizador de protocolo”.

### 2.2 Commerce e confiança

- Botão **Buy** em cada card pode parecer **afiliado/venda** — útil para receita,
  mas reduz percepção de neutralidade e pode conflitar com App Store guidelines
  em categorias sensíveis.
- Tab **Shop** expande escopo para e-commerce; distrai do core tracker.

### 2.3 Complexidade e manutenção

- **104 entradas** exigem curadoria contínua (half-life errado = perda de
  confiança).
- Modos Calculator (Blend, Cycle, Cost) + Inventory + Courses + Community + FAQ
  = **superfície enorme** — difícil manter qualidade em tudo.
- Comparar peptídeos, stacks, múltiplos frascos: poderoso, mas intimidante para
  iniciante GLP-1.

### 2.4 Possíveis gaps (não visíveis nas capturas)

- Sync/conta cloud (não confirmado nas imagens).
- Qualidade real do Tracker (streaks, curvas PK, body map) — só vimos nav icons.
- Privacidade: catálogo rico + Q&A + Shop sugere backend; nosso wedge
  **local-first** continua válido se comunicarmos bem.

---

## 3. Onde estamos hoje (honesto)

| Área | Concorrente (capturas) | Nosso app |
|---|---|---|
| Library | 104 itens, filtros, compare, buy | 13 itens, busca, filtro, detalhe |
| Calculator | Wizard, seringa, blend, library link | Fórmula manual básica |
| Inventory | Completo | Inexistente |
| Tracker / Progress | Tab dedicado (não detalhado) | History em Progress, sem charts |
| Engagement | Provável (Tracker tab) | Sem streaks/recap |
| Visual PK / body map | Provável no Tracker | Inexistente |
| Integração entre módulos | Forte | Fraca |
| Ads | Não visíveis | Planejado como floor free (revisar) |
| Compliance | Arriscado | Conservador (força) |

Conclusão: não estamos “perto” em amplitude de features — estamos **perto em
arquitetura de abas** e **começando** a Library. Falta o **glue** (integração) e
3–4 features table-stakes da categoria.

---

## 4. O que “competir minimamente” significa

Não é igualar 104 peptídeos + Shop + Courses no v1. É ser **credível na primeira
sessão** para os dois segmentos:

1. **GLP-1:** “Entendo minha dose semanal, vejo progresso, rodo site de injeção.”
2. **Research/TRT:** “Reconstituo com visual, salvo recipe, sei quantas doses
   restam no frasco.”

Meta de paridade mínima (MVP competitivo):

- Usuário abre Library → toca **Calculate** → vê seringa + mL/units → salva log
  → vê adherence/streak na Progress — **sem sair do fluxo mental do concorrente**.
- Sem ads na v1 pública (subscription-first; ads só se experimento provar CPM).
- Library com **30–50** entradas curadas (qualidade > quantidade).
- Compliance intacto: nunca “dose recomendada” ou “dosing looks good”.

---

## 5. Próximos passos — roadmap priorizado

### Fase 1 — Glue (4–6 semanas) · fechar sensação de “incompleto”

Prioridade máxima: integração entre o que já existe.

| # | Entrega | Por quê |
|---|---|---|
| 1.1 | **Library → Calculator**: passar `compoundId`, preencher unidade default e mostrar half-life no header | Copia o Step 1 do concorrente |
| 1.2 | **Calculator wizard** (3 passos): Vial setup → Your dose → Review + seringa visual | Table-stakes da categoria |
| 1.3 | **Live preview** de concentração (mg/mL) enquanto digita | Feedback instantâneo |
| 1.4 | **Seringa visual** + seletor 0.3/0.5/1.0 mL + conversão mL ↔ units | Screenshot-worthy |
| 1.5 | **Salvar recipe** local (nome, vial mg, diluent mL, dose desejada) | Retention |
| 1.6 | Expandir JSON para **~30 compostos** prioritários (top GLP-1 + Wolverine stack + GH secretagogues) | Library deixa de parecer demo |

**Não fazer ainda:** Shop, Buy, Q&A, Compare, Courses.

### Fase 2 — Retention engine (3–4 semanas)

| # | Entrega | Por quê |
|---|---|---|
| 2.1 | **Streak + adherence %** na Today (derivado de logs + schedule) | Payoff imediato pós-log |
| 2.2 | **Weekly recap** na Progress | Habit loop semanal |
| 2.3 | **Weight / measurement log** simples + sparkline | Segmento GLP-1 |
| 2.4 | **Injection site** no log + hint “last site” (free) | Valor diário concreto |

### Fase 3 — Depth que justifica Pro (4–6 semanas)

| # | Entrega | Por quê |
|---|---|---|
| 3.1 | **Inventory**: frasco, remaining, concentração, expiry | Paridade com capturas de Inventory |
| 3.2 | **Body map** 12 sites + histórico (Pro) | Diferencial sticky |
| 3.3 | **Medication-level curve** (half-life do JSON + logs) | “Wow” visual da categoria |
| 3.4 | **Calculator Blend mode** (2 peptídeos, math only) | Segmento research |
| 3.5 | **Export CSV / PDF** | Pro feature clara |

### Fase 4 — Escala de conteúdo (contínuo)

| # | Entrega | Por quê |
|---|---|---|
| 4.1 | Library **50 → 100+** entradas com pipeline editorial | ASO long-tail |
| 4.2 | Accordions no detalhe: Science, Logging notes, Sources (sem “Benefits”) | Profundidade compliant |
| 4.3 | Busca por alias/marca (Ozempic → Semaglutide) | Já parcialmente feito |
| 4.4 | Remote config do JSON (opcional) | Atualizar catálogo sem release |

---

## 6. Melhorias de UX específicas (inspiradas, adaptadas)

Copiar **padrão**, não **copy** literal:

| Concorrente | Nossa versão compliant |
|---|---|
| “Calculate Dose” | “Open calculator with this compound” |
| “Dosing looks good” | “Math checks out for the values you entered” |
| “Typical Dosage Range” | “Reported patterns in sources” (já temos) |
| “Benefits” accordion | “What literature discusses” ou omitir |
| “Buy” | Omitir v1; eventual link externo “Learn more” sem afiliado |
| Step wizard | Manter; renomear para “Vial → Dose → Draw → Save” |
| Select from Library | Bottom sheet com busca + half-life badge |

---

## 7. Monetização vs concorrente sem ads

Hipótese alinhada às capturas:

| Tier | Free | Pro (~$5.99–9.99/mo ou $39.99/yr) |
|---|---|---|
| Logging | 1 rotina ativa | Ilimitado |
| Library | Leitura completa | Leitura + favoritos offline |
| Calculator | Single + seringa básica | Blend, recipes ilimitadas, inventory |
| Progress | Streak + history 30d | Curves PK, body map, export |
| Ads | **Nenhum** na v1 | N/A |

Evitar ads intersticiais — o concorrente prova que **sem ads + subscription** é
viável neste nicho.

---

## 8. Métricas de “competir minimamente”

Antes de escalar marketing, validar:

| Métrica | Alvo |
|---|---|
| D1 retention | >40% |
| Library → Calculator tap rate | >25% of Library sessions |
| Calculator → Log completion | >15% |
| D7 retention | >20% |
| Pro trial start (quando existir) | >5% of WAFU |

Se Library → Calculator estiver baixo, o glue ainda está quebrado.

---

## 9. Resumo executivo

**O concorrente ganha** por integração (Library + Calculator + Inventory),
calculadora visual em passos, catálogo massivo e polish — não por ser
tecnicamente superior em compliance.

**Nós ganhamos** se entregarmos o **fluxo mínimo integrado** em 6–8 semanas,
mantendo local-first + linguagem educacional, e adicionarmos streak/inventory/
curves antes de pensar em Shop ou 100+ peptídeos.

**Ordem recomendada:** Glue (Library↔Calculator↔Recipe) → Habit (streak/recap) →
Inventory + body map + curves → escala de conteúdo.

**Não copiar:** Buy button, “benefits”, validação de dose como endorsement, Q&A
médico, ads agressivos.

---

## 10. Referências internas

- `docs/product/v2-product-vision.md` — pilares Knowledge / Precision / Habit
- `docs/product/app-restructure-and-redesign-plan.md` — fases técnicas
- `docs/product/engagement-and-monetization-strategy.md` — loops e pricing
- `docs/research/peptide-market-and-competitor-analysis.md` — mercado
- `assets/library/compounds.json` — catálogo atual (13 entradas)
- Capturas do concorrente: `assets/WhatsApp_Image_2026-06-06_*.png`
