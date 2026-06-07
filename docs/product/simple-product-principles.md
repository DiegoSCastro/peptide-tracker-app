# Easy Peptide Tracker — princípios de produto simples

Status: direção de produto (prevalece sobre feature parity com concorrentes)  
Data: 2026-06-06  
Nome de exibição: **Easy Peptide Tracker**

## North star

> Registrar rotinas e doses com o mínimo de taps — sem enciclopédia, sem
> dashboard pesado, sem ruído.

Três palavras: **Simple. Private. Useful.**

## O que “simples” significa aqui

| Sim | Não |
|---|---|
| Log em 2–3 taps | Wizard de 6 passos para tarefas diárias |
| Library enxuta: o essencial quando você busca | 100+ cards com Benefits, Compare, Buy |
| Calculator: 3 campos + resultado claro | Modos Blend / Cycle / Cost no v1 |
| Today = o que importa **hoje** | Métricas e gráficos na home |
| Progress = histórico + 1 número de consistência | Dashboard analítico |
| Detalhe do composto: 1 tela, seções colapsáveis | Páginas longas sempre abertas |

**Regra:** se a feature não ajuda a *logar*, *lembrar*, ou *calcular uma vez*,
ela espera.

## Posicionamento vs concorrente

O concorrente das capturas é um **centro de informação + ferramentas**.  
Easy Peptide Tracker é um **caderno digital inteligente**:

- Menos conteúdo, mais contexto no momento certo.
- Library = referência rápida (half-life, padrões reportados, link p/ calculator).
- Sem Shop, Buy, Compare, Courses, Q&A.
- Sem ads.

Competimos em **facilidade e clareza**, não em volume de dados.

## Escopo mínimo competitivo (versão simples)

Mantém 4 abas + Log central:

1. **Today** — due, log rápido, 4 action cards, streak simples (futuro).
2. **Protocols** — criar/editar rotina sem jargão.
3. **Library** — busca + ~20–30 compostos curados; detalhe **curto** por padrão.
4. **Progress** — timeline de logs + adherence % (um número, não dez gráficos).

**Settings** na engrenagem. Calculator acessível da Today e da Library.

### Glue (prioridade, mas enxuto)

- Library → Calculator com compound pré-selecionado.
- Calculator: vial mg + diluent mL + dose → mL a puxar (+ seringa visual simples).
- **Não** inventory completo no v1 simples — só “doses restantes” opcional depois.

## Library — quanto conteúdo é suficiente

Por composto, **no máximo**:

- Nome + 1 linha de resumo no card.
- Detalhe: What it is (1 parágrafo), half-life, 1–2 padrões reportados,
  fonte, disclaimer.
- Ocultar por padrão: mecanismo longo, listas longas de highlights.

Meta de catálogo: **20–30 compostos** bem curados (GLP-1 + stacks comuns),
não 104.

## Tom de copy

- “Reported in sources” — nunca “recommended dose”.
- “Your values” — nunca “optimal dose”.
- Botões: **Log**, **Calculate**, **View history** — verbos curtos.

Ver `docs/compliance/compliance-language-pack.md`.

## Monetização alinhada à simplicidade

- Free: 1 rotina, library completa, calculator básica, sem ads.
- Pro (futuro): rotinas ilimitadas, export, body map, curva PK — **opt-in**, não
  empurrar na home.

## Próximos passos (ordem, visão simples)

1. Renomear app → **Easy Peptide Tracker** (feito em `app.dart`, onboarding, stores).
2. Encurtar tela de detalhe da Library (accordions / “Show more”).
3. Calculator wizard **3 passos** (não 4+) + link da Library.
4. Streak/adherence **um chip** na Today (não página dedicada).
5. Expandir JSON só até ~25 compostos; parar.

## O que adiamos de propósito

- Inventory multi-frasco
- Blend / Cycle / Cost calculator
- Body map (Pro, fase 2)
- Medication-level curves (Pro, fase 2)
- Community, courses, shop, compare
- 100+ library entries

Referências: `docs/product/competitor-gap-analysis-and-next-steps.md` (análise
completa; este doc **restringe** o escopo).
