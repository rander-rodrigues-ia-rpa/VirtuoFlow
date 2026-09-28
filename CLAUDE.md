# CLAUDE.md

Guia para agentes (Claude Code) trabalhando neste repositório.

## Visão geral

Site institucional estático da **VirtuoFlow** (https://virtuoflow.com.br) — consultoria em IA, fábrica de software e produtos SaaS. Todo o conteúdo é em **português do Brasil**.

Não há build, bundler ou dependências locais: são arquivos HTML puros servidos por Nginx.

## Estrutura

```
index.html          Landing page (única página comercial)
privacidade.html    Política de Privacidade (exigida pelo Google Sign-In dos produtos)
assets/
  logo.svg          Logo horizontal (símbolo + wordmark) para fundo escuro
  logo-light.svg    Logo horizontal para fundo claro
  logo-mark.svg     Apenas o símbolo (monograma V-Flow)
  favicon.svg       Favicon (símbolo sobre tile escuro)
  og-image.svg      Fonte da imagem de compartilhamento (Open Graph)
  og-image.png      PNG 1200x630 usado no og:image (redes sociais não aceitam SVG)
  apple-touch-icon.png  Ícone 180x180 para iOS
Dockerfile          nginx:alpine; copia o repo para /usr/share/nginx/html
.dockerignore       Exclui .git, docs e arquivos de dev da imagem
```

## Stack e convenções

- **Tailwind CSS via CDN** (`https://cdn.tailwindcss.com`) com `tailwind.config` inline em cada página. Não introduzir build step sem necessidade.
- Fontes via Google Fonts: **Plus Jakarta Sans** (texto/títulos) e **JetBrains Mono** (rótulos técnicos).
- CSS customizado mínimo em `<style>` no `<head>`; JS vanilla mínimo no final do `<body>` (menu mobile, animações de revelação no scroll). Sem frameworks JS.
- O logo é usado **inline** (SVG) no header/rodapé do `index.html` para permitir animação; os arquivos em `assets/` são a fonte oficial da marca.
- Mantenha os links de contato consistentes:
  - WhatsApp: `https://wa.me/5531990920985?text=...` (mensagem pré-preenchida URL-encoded)
  - E-mail: `comercial@virtuoflow.com.br`

## Identidade visual

| Token        | Cor       | Uso                                   |
|--------------|-----------|---------------------------------------|
| `flow-sky`   | `#38BDF8` | Destaque, "Flow" no wordmark, nó do símbolo |
| `flow-blue`  | `#2563EB` | Cor primária, botões                  |
| `flow-indigo`| `#4F46E5` | Fim dos gradientes                    |
| `flow-navy`  | `#1E3A8A` | Profundidade (haste esquerda do V)    |
| `ink`        | `#05070D` | Fundo principal                       |
| `ink-2`      | `#0A0F1C` | Fundo de cards/seções alternadas      |

- Gradiente da marca: `#38BDF8 → #2563EB → #4F46E5` (135°).
- Wordmark: "Virtuo" em peso 800 + "Flow" em peso 400 na cor sky.
- Tagline: "SOLUÇÕES EM IA & TECNOLOGIA".

## Rodando localmente

```bash
docker build -t virtuoflow . && docker run --rm -p 8080:80 virtuoflow
```

Ou simplesmente abra `index.html` no navegador / `python -m http.server`.

O Nginx está configurado (via `sed` no Dockerfile) para resolver URLs sem extensão, então `/privacidade` serve `privacidade.html`.

## Checklist ao alterar o site

- Testar em largura de celular (~375px): sem rolagem horizontal, menu mobile funcionando.
- Manter `lang="pt-BR"`, meta description e tags Open Graph atualizadas.
- Respeitar `prefers-reduced-motion` nas animações.
