*[Read in English](README.md)*

<p align="center">
  <picture>
    <img src="cloche-logo/watermark.png" alt="Cloche OS Logo" height="80" />
  </picture>
</p>

<p align="center">
    <strong>Workstation de Performance & Gaming</strong>
</p>

<p align="center">
  <strong>Cloche Xe</strong> é uma série de imagens de desktop imutáveis e container-native construídas sobre o Bazzite, voltadas a uma workstation focada em performance e gaming — incluindo uma variante otimizada para o Steam Deck.
</p>

<p align="center">
  <a href="https://github.com/cloche-project/cloche-xe/actions/workflows/build.yml">
    <img src="https://github.com/cloche-project/cloche-xe/actions/workflows/build.yml/badge.svg" alt="Build Status" />
  </a>
  <a href="https://ghcr.io/cloche-project/cloche-xe">
    <img src="https://img.shields.io/badge/registry-GHCR-blue?logo=github" alt="GHCR Registry" />
  </a>
  <img src="https://img.shields.io/github/license/cloche-project/cloche-xe" alt="License" />
</p>

> [!NOTE]
> **O Cloche Xe herda do [Bazzite](https://github.com/ublue-os/bazzite), e não da Base Headless do Cloche.** Ele aplica os mesmos padrões de desktop do Cloche (`cloche-gnome-defaults`/`cloche-kde-defaults`, vindos do [`rpm-repo`](https://github.com/cloche-project/rpm-repo)) sobre a stack de gaming/performance do Bazzite, em vez de construir o desktop do zero como faz o `cloche-standard`.

---

## Variantes Disponíveis

| Nome da Imagem | Ambiente Desktop | Caso de Uso |
|------------|---------------------|-----------------|
| `cloche-xe` | KDE Plasma | Workstation focada em performance/gaming |
| `cloche-xe-gnome` | GNOME (nativo Wayland) | Workstation focada em performance/gaming |
| `cloche-xe-deck` | KDE Plasma | Otimizado para Steam Deck |
| `cloche-xe-deck-gnome` | GNOME | Otimizado para Steam Deck |

---

## Arquitetura do Desktop

| Componente | Detalhes |
|-----------|---------|
| **Camada Base** | Bazzite (`ghcr.io/ublue-os/bazzite[-gnome\|-deck\|-deck-gnome]`), acompanhando o canal `stable`/`testing` — o Bazzite não usa uma tag `latest` contínua |
| **Instalação de Pacotes** | Módulo `script` (`install-*-packages.sh`, `setup-cloche-xe*.sh`) instalando `cloche-gnome-defaults`/`cloche-kde-defaults` do `rpm-repo` do Cloche, os mesmos RPMs usados pelo `cloche-standard` |
| **Entrega de Apps** | Flatpak, com um conjunto padrão de apps pré-instalados no nível do sistema |
| **Suporte a Hardware** | Herda a stack de drivers e ajustes de performance voltados a gaming do Bazzite |

---

## Principais Recursos do Desktop

* **Padrões de Desktop Compartilhados:** Temas GNOME/Plasma, papéis de parede e configuração do shell vêm dos mesmos RPMs `cloche-*-defaults` usados pelo `cloche-standard`, mantendo a experiência de desktop consistente em toda a família Cloche.
* **Base Pronta para Gaming:** Construído sobre o Bazzite, então gamemode, suporte a controles e gerenciamento de drivers de GPU já vêm ajustados de fábrica.
* **Flatpaks Selecionados:** Vem com um conjunto padrão de apps (VSCodium, Podman Desktop, Amberol, LocalSend, Resources, entre outros) via `default-flatpaks`, com um conjunto focado em Blender/Gear Lever na variante Deck.
* **Variante Steam Deck:** `cloche-xe-deck`/`cloche-xe-deck-gnome` são construídas sobre as próprias imagens Deck do Bazzite, voltadas ao formato portátil.

---

## Implantação & Instalação

### Rebase Remoto

Para migrar uma workstation Fedora Atomic existente para o Cloche Xe, escolha sua variante preferida e execute:

```bash
# Exemplo: rebase para a variante Plasma
rpm-ostree rebase ostree-unverified-registry:ghcr.io/cloche-project/cloche-xe:latest

# Ou para a variante GNOME
rpm-ostree rebase ostree-unverified-registry:ghcr.io/cloche-project/cloche-xe-gnome:latest
```

### Aplique as camadas de desktop reiniciando o sistema:

```bash
systemctl reboot
```

### Passos Recomendados Pós-Instalação

* **Verificar Camadas:** Rode `rpm-ostree status` para garantir que a base e os overrides locais estão de acordo com o esperado.
* **Configurar Flatpaks:** Os remotes do Flatpak já vêm configurados no nível do sistema; apps de usuário podem ser adicionados sem privilégios de root via Central de Software ou CLI.

---

## Verificação & Segurança

Todo build de imagem de desktop é assinado via Sigstore Cosign contra a chave pública de verificação do repositório.

```bash
# Verificar a camada da variante de desktop específica
cosign verify --key cosign.pub ghcr.io/cloche-project/cloche-xe:latest
```

## Licença & Agradecimentos

* Licenciado sob Apache 2.0
* Construído sobre a imagem [Bazzite](https://github.com/ublue-os/bazzite) da Universal Blue
* Compartilha os padrões de desktop com o `cloche-project/cloche-standard` via `cloche-project/rpm-repo`
* Powered by o framework BlueBuild e os engines do projeto Universal Blue
