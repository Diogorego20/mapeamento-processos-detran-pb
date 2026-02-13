# Geração de Organogramas de Procedimentos - DETRAN-PB

Este repositório contém o script R e os resultados da geração de organogramas de procedimentos operacionais do DETRAN-PB. O objetivo deste projeto é padronizar e documentar os fluxos de trabalho internos, melhorando a comunicação, o treinamento e a eficiência dos processos.

## 🎯 Importância e Benefícios

A criação de organogramas de procedimentos é fundamental para a modernização e otimização dos serviços públicos. Os principais benefícios incluem:

- **Padronização de Processos**: Garante que todos os funcionários sigam as mesmas etapas, reduzindo erros e inconsistências.
- **Melhora na Comunicação Interna**: Facilita o entendimento dos fluxos de trabalho entre diferentes setores e níveis hierárquicos.
- **Treinamento de Novos Colaboradores**: Serve como material didático visual para capacitar novos estagiários e funcionários de forma rápida e eficiente.
- **Identificação de Gargalos**: Permite visualizar o fluxo completo e identificar pontos de lentidão ou ineficiência que podem ser otimizados.
- **Base de Conhecimento**: Cria uma base de conhecimento documentada e de fácil consulta para todos os colaboradores.
- **Transparência e Clareza**: Aumenta a transparência dos processos internos, facilitando a gestão e a tomada de decisões.

## 📂 Estrutura do Repositório

- **/organogramas_detran/**: Subpasta principal do projeto.
  - `README.md`: Este arquivo, com a explicação do projeto.
  - `criar_organogramas.R`: Script R para gerar os organogramas.
  - **/resultados/**: Pasta com os organogramas gerados em formato PNG.
    - `organograma_antifraude_detran_pb.png`: Fluxograma do procedimento de análise antifraude.
    - `organograma_coleta_liberacao_veiculos_detran_pb.png`: Fluxograma do procedimento de coleta e liberação de veículos.

## 🚀 Como Usar

### Pré-requisitos

- **R e RStudio**: É necessário ter o R e o RStudio instalados no seu computador.
- **Terminal (Mac/Linux) ou Git Bash (Windows)**: Para clonar o repositório e enviar os arquivos.

### Passos para Execução

1. **Clone o repositório** para o seu computador:
   ```bash
   git clone https://github.com/Diogorego20/detran-policiamento-splas.git
   ```

2. **Navegue até a pasta do projeto**:
   ```bash
   cd detran-policiamento-splas/organogramas_detran
   ```

3. **Abra o RStudio** e execute o script `criar_organogramas.R`:
   - O script instalará os pacotes necessários e gerará os organogramas na pasta `/resultados/`.

4. **Envie os arquivos para o GitHub**:
   ```bash
   git add .
   git commit -m "Adiciona script R e organogramas de procedimentos"
   git push origin main
   ```

## 🛠️ Sobre o Script R

O script `criar_organogramas.R` utiliza o pacote `DiagrammeR` para criar os fluxogramas a partir de uma sintaxe declarativa (DOT language). Ele é dividido em seções:

1. **Instalação e Carregamento de Pacotes**: Prepara o ambiente R.
2. **Função Auxiliar `exportar_organograma`**: Exporta os gráficos para PNG em alta resolução.
3. **Organograma 1: Análise Antifraude**: Código para gerar o fluxograma de análise antifraude.
4. **Organograma 2: Coleta e Liberação de Veículos**: Código para gerar o fluxograma de coleta e liberação.

## 👨‍💻 Autor

- **Diogo Rego**
- Estudante de Estatística - UFPB
- Estagiário | DETRAN-PB
- GitHub: [Diogorego20](https://github.com/Diogorego20)

---
*Este projeto foi desenvolvido como parte do programa de estágio no DETRAN-PB, com o objetivo de contribuir para a melhoria e documentação dos processos internos.*
