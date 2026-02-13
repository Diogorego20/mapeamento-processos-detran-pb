# ==============================================================================
# SCRIPT R: GERAÇÃO DE ORGANOGRAMAS DE PROCEDIMENTOS - DETRAN-PB
# ==============================================================================
# Autor: Diogo Rego
# Cargo: Estagiário | Estatística - UFPB
# Instituição: DETRAN-PB | Governo do Estado da Paraíba
# Data: Fevereiro/2026
# GitHub: https://github.com/Diogorego20/detran-policiamento-splas
# ==============================================================================

# DESCRIÇÃO:
# Este script R cria organogramas profissionais de procedimentos operacionais
# do DETRAN-PB usando o pacote DiagrammeR. Os organogramas são exportados em
# formato PNG de alta resolução para uso em documentação interna, treinamentos
# e comunicação institucional.

# ==============================================================================
# 1. INSTALAÇÃO E CARREGAMENTO DE PACOTES
# ==============================================================================

# Instalar pacotes necessários (executar apenas uma vez)
install.packages(c("DiagrammeR", "DiagrammeRsvg", "rsvg", "magick"))

# Carregar bibliotecas
library(DiagrammeR)      # Criação de diagramas e fluxogramas
library(DiagrammeRsvg)   # Exportação para SVG
library(rsvg)            # Conversão de SVG para PNG
library(magick)          # Manipulação de imagens

# ==============================================================================
# 2. FUNÇÃO AUXILIAR: EXPORTAR ORGANOGRAMA PARA PNG
# ==============================================================================

exportar_organograma <- function(grafico, nome_arquivo, largura = 2000, altura = 3000) {
  # Exporta o organograma para PNG em alta resolução
  # 
  # Args:
  #   grafico: Objeto grViz do DiagrammeR
  #   nome_arquivo: Nome do arquivo PNG de saída (sem extensão)
  #   largura: Largura da imagem em pixels (padrão: 2000)
  #   altura: Altura da imagem em pixels (padrão: 3000)
  
  # Converter para SVG
  svg_temp <- DiagrammeRsvg::export_svg(grafico)
  
  # Converter SVG para PNG
  rsvg::rsvg_png(
    charToRaw(svg_temp),
    file = paste0(nome_arquivo, ".png"),
    width = largura,
    height = altura
  )
  
  cat(paste0("✓ Organograma exportado: ", nome_arquivo, ".png\n"))
}

# ==============================================================================
# 3. ORGANOGRAMA 1: ANÁLISE ANTIFRAUDE
# ==============================================================================

organograma_antifraude <- grViz("
digraph antifraude {
  
  # Configurações globais
  graph [layout = dot, rankdir = TB, fontname = 'Arial', bgcolor = 'white']
  node [shape = box, style = 'rounded,filled', fontname = 'Arial', fontsize = 10]
  edge [fontname = 'Arial', fontsize = 9]
  
  # Nós do fluxograma
  inicio [label = 'INÍCIO\\nUsuário solicita\\nserviço', shape = ellipse, fillcolor = '#4CAF50', fontcolor = 'white']
  
  etapa1 [label = 'ETAPA 1\\nVERIFICAÇÃO PRELIMINAR\\n\\nCódigo: VERIF-PRELIM-DOC\\nResponsável: Analista\\n\\nAções:\\n• Inspeção visual\\n• Verificar legibilidade\\n• Conferir selo cartorial', fillcolor = '#E3F2FD']
  
  decisao1 [label = 'Documento\\naprovado?', shape = diamond, fillcolor = '#FFF9C4']
  
  rejeicao [label = 'REJEIÇÃO\\nDOCUMENTAL\\n\\nSolicitar correções', shape = box, fillcolor = '#EF5350', fontcolor = 'white']
  
  etapa2 [label = 'ETAPA 2\\nVALIDAÇÃO DIGITAL\\n\\nCódigo: VALID-AUTENT-DIGIT\\n\\nAções:\\n• Escanear QR Code\\n• Validar domínio .jus.br\\n• Acessar sistema TJ', fillcolor = '#E3F2FD']
  
  decisao2 [label = 'Autenticidade\\nconfirmada?', shape = diamond, fillcolor = '#FFF9C4']
  
  fraude [label = 'BLOQUEIO\\nIMEDIATO\\n\\nReportar Fraude', shape = box, fillcolor = '#D32F2F', fontcolor = 'white']
  
  etapa3 [label = 'ETAPA 3\\nANÁLISE DE PRAZO\\n\\nCódigo: ANALIS-PRAZO-VALID\\n\\nRegras:\\n• Operações Padrão: 30 dias\\n• Processos Sensíveis: 60 dias', fillcolor = '#C8E6C9']
  
  decisao3 [label = 'Dentro do\\nprazo?', shape = diamond, fillcolor = '#FFF9C4']
  
  atualizar [label = 'SOLICITAR\\nDOCUMENTAÇÃO\\nATUALIZADA', shape = box, fillcolor = '#FF9800', fontcolor = 'white']
  
  etapa4 [label = 'ETAPA 4\\nCONFERÊNCIA EM BASES\\n\\nCódigo: CONF-BASES-OFIC\\n\\nConsultas:\\n• RENAVAM\\n• RENACH\\n• CPF (Receita Federal)', fillcolor = '#E3F2FD']
  
  decisao4 [label = 'Dados\\nconfirmados?', shape = diamond, fillcolor = '#FFF9C4']
  
  etapa5 [label = 'ETAPA 5\\nVERIFICAÇÃO DE PROCURAÇÃO\\n\\nCódigo: VERIF-PROCUR-DESP\\n\\nCaracterísticas:\\n• Poderes amplos\\n• Procurações antigas\\n• Sem firma reconhecida', fillcolor = '#FFF3E0']
  
  decisao5 [label = 'Procuração\\naprovada?', shape = diamond, fillcolor = '#FFF9C4']
  
  rejeitar [label = 'REJEITAR\\nPROCURAÇÃO', shape = box, fillcolor = '#EF5350', fontcolor = 'white']
  
  etapa6 [label = 'ETAPA 6\\nVERIFICAÇÃO DE\\nCREDENCIAMENTO\\n\\nCódigo: VERIF-CRED-DESP\\n\\nAções:\\n• Verificar cadastro\\n• Credenciamento superior', fillcolor = '#E3F2FD']
  
  decisao6 [label = 'Credenciamento\\nválido?', shape = diamond, fillcolor = '#FFF9C4']
  
  bloquear [label = 'BLOQUEAR\\nDESPACHANTE', shape = box, fillcolor = '#D32F2F', fontcolor = 'white']
  
  etapa7 [label = 'ETAPA 7\\nANÁLISE DE SOLICITAÇÕES\\nDE ALTO RISCO\\n\\nCódigo: ANALIS-SOLIC-ALTO-RISCO\\n\\nIndicador de Risco 3:\\n• Baixa veículo\\n• Transferência cadastro\\n• Alteração dados', fillcolor = '#E1BEE7']
  
  decisao7 [label = 'Solicitação\\naprovada?', shape = diamond, fillcolor = '#FFF9C4']
  
  rejeitar_solic [label = 'REJEITAR\\nSOLICITAÇÃO', shape = box, fillcolor = '#EF5350', fontcolor = 'white']
  
  etapa8 [label = 'ETAPA 8\\nVERIFICAÇÃO DE\\nDIVERGÊNCIAS NO SELO\\n\\nCódigo: VERIF-DIVERG-SELO\\n\\nIndicador de Risco 4:\\n• Divergência Dados Selo\\n• Bloquear imediatamente', fillcolor = '#FFCDD2']
  
  decisao8 [label = 'Análise\\ncomportamental\\nsegura?', shape = diamond, fillcolor = '#FFF9C4']
  
  reportar [label = 'REPORTAR\\nALERTA\\nCOMPORTAMENTAL', shape = box, fillcolor = '#8B0000', fontcolor = 'white']
  
  etapa9 [label = 'ETAPA 9\\nANÁLISE COMPORTAMENTAL\\n\\nCódigo: ANALIS-COMPORT-DESP\\n\\nSinais de Alerta:\\n• Pressão acelerar\\n• Exercimento inadequado\\n• Manter profissionalismo', fillcolor = '#B71C1C', fontcolor = 'white']
  
  decisao9 [label = 'Processo\\nconcluído\\naprovado?', shape = diamond, fillcolor = '#FFF9C4']
  
  fim [label = 'FIM\\nDOCUMENTAÇÃO\\nAPROVADA', shape = ellipse, fillcolor = '#4CAF50', fontcolor = 'white']
  
  # Conexões do fluxo
  inicio -> etapa1
  etapa1 -> decisao1
  decisao1 -> rejeicao [label = 'NÃO']
  decisao1 -> etapa2 [label = 'SIM']
  etapa2 -> decisao2
  decisao2 -> fraude [label = 'NÃO']
  decisao2 -> etapa3 [label = 'SIM']
  etapa3 -> decisao3
  decisao3 -> atualizar [label = 'NÃO']
  decisao3 -> etapa4 [label = 'SIM']
  etapa4 -> decisao4
  decisao4 -> fraude [label = 'NÃO']
  decisao4 -> etapa5 [label = 'SIM']
  etapa5 -> decisao5
  decisao5 -> rejeitar [label = 'NÃO']
  decisao5 -> etapa6 [label = 'SIM']
  etapa6 -> decisao6
  decisao6 -> bloquear [label = 'NÃO']
  decisao6 -> etapa7 [label = 'SIM']
  etapa7 -> decisao7
  decisao7 -> rejeitar_solic [label = 'NÃO']
  decisao7 -> etapa8 [label = 'SIM']
  etapa8 -> decisao8
  decisao8 -> reportar [label = 'NÃO']
  decisao8 -> etapa9 [label = 'SIM']
  etapa9 -> decisao9
  decisao9 -> reportar [label = 'NÃO']
  decisao9 -> fim [label = 'SIM']
  
  # Retornos
  rejeicao -> etapa1 [style = dashed, label = 'Corrigir']
  atualizar -> etapa3 [style = dashed, label = 'Retornar']
  rejeitar -> etapa5 [style = dashed, label = 'Retornar']
}
")

# Visualizar organograma
print(organograma_antifraude)

# Exportar para PNG
exportar_organograma(organograma_antifraude, "organograma_antifraude_detran_pb", 2400, 3600)

# ==============================================================================
# 4. ORGANOGRAMA 2: COLETA E LIBERAÇÃO DE VEÍCULOS
# ==============================================================================

organograma_coleta <- grViz("
digraph coleta {
  
  # Configurações globais
  graph [layout = dot, rankdir = TB, fontname = 'Arial', bgcolor = 'white']
  node [shape = box, style = 'rounded,filled', fontname = 'Arial', fontsize = 10]
  edge [fontname = 'Arial', fontsize = 9]
  
  # Nós do fluxograma
  inicio [label = 'INÍCIO\\nUsuário chega\\npara retirada\\nde veículo', shape = ellipse, fillcolor = '#4CAF50', fontcolor = 'white']
  
  etapa1 [label = 'ETAPA 1\\nRECEPÇÃO E TRIAGEM\\n\\nCódigo: RECEP-TRIAG-USU\\nResponsável: Tenda - Atendimento\\n\\nAções:\\n• Receber usuário\\n• Verificar tipo de solicitação\\n• Encaminhar para processo', fillcolor = '#BBDEFB']
  
  decisao1 [label = 'Possui\\ndocumentação\\ncompleta?', shape = diamond, fillcolor = '#FFF9C4']
  
  orientar [label = 'Orientar sobre\\ndocumentos\\nnecessários\\n(retornar)', shape = box, fillcolor = '#FF9800', fontcolor = 'white']
  
  etapa2 [label = 'ETAPA 2\\nABERTURA DE PROCESSO\\nNO PBDOC\\n\\nCódigo: ABERT-PROC-PBDOC\\nResponsável: Funcionária Sol / Estagiários\\n\\nAções:\\n• Receber documentação\\n• Abrir processo no PBDoc\\n• Digitalizar documentos\\n• Gerar protocolo', fillcolor = '#C5CAE9']
  
  etapa3 [label = 'ETAPA 3\\nCONSULTA DE RESTRIÇÕES\\nNO APX\\n\\nCódigo: CONS-REST-APX\\nResponsável: Agente de Liberação\\nSistemas: APX, Remajude, Remait\\n\\nAções:\\n• Verificar restrições\\n• Consultar restrições\\n• Verificar bloqueios', fillcolor = '#B2DFDB']
  
  decisao2 [label = 'Veículo possui\\nrestrições?', shape = diamond, fillcolor = '#FFF9C4']
  
  etapa4 [label = 'ETAPA 4\\nANÁLISE DE RESTRIÇÕES\\n\\nCódigo: ANALIS-REST-VEI\\nResponsável: Agente de Liberação\\n\\nAções:\\n• Identificar tipo de restrição\\n• Verificar possibilidade de regularização', fillcolor = '#FFCCBC']
  
  decisao3 [label = 'Pode ser\\nregularizada\\nno local?', shape = diamond, fillcolor = '#FFF9C4']
  
  informar [label = 'Informar impossibilidade\\n(FIM - Bloqueado)', shape = box, fillcolor = '#EF5350', fontcolor = 'white']
  
  etapa5 [label = 'ETAPA 5\\nCONSULTA DE DÉBITOS E\\nLICENCIAMENTO\\n\\nCódigo: CONS-DEB-LIC\\nResponsável: Agente de Liberação\\nSistema: APX\\n\\nVerificações:\\n• IPVA\\n• Multas\\n• Licenciamento\\n• Taxas', fillcolor = '#C8E6C9']
  
  decisao4 [label = 'Débitos\\nencontrados?', shape = diamond, fillcolor = '#FFF9C4']
  
  etapa6 [label = 'ETAPA 6\\nAGUARDAR COMPENSAÇÃO\\nDE PAGAMENTO\\n\\nCódigo: AGUARD-COMP-PAG\\nResponsável: Agente de Liberação\\n\\nAções:\\n• Usuário realiza pagamento\\n• Aguardar compensação\\n• Verificar baixa no sistema', fillcolor = '#FFE082']
  
  decisao5 [label = 'Pagamento\\ncompensado?', shape = diamond, fillcolor = '#FFF9C4']
  
  aguardar [label = 'Aguardar\\n(retornar)', shape = box, fillcolor = '#FF9800', fontcolor = 'white']
  
  etapa7 [label = 'ETAPA 7\\nVERIFICAÇÃO DE PLACA\\nDO VEÍCULO\\n\\nCódigo: VERIF-PLACA-VEI\\nResponsável: Agente de Liberação\\n\\nAções:\\n• Verificar se veículo possui placa\\n• Consultar situação da placa', fillcolor = '#E1BEE7']
  
  decisao6 [label = 'Veículo possui\\nplaca?', shape = diamond, fillcolor = '#FFF9C4']
  
  etapa8 [label = 'ETAPA 8\\nPROCESSO DE EMPLACAMENTO\\n\\nCódigo: PROC-EMPLAC-VEI\\nResponsável: Setor de Emplacamento\\n\\nAções:\\n• Solicitar documentação\\n• Gerar requisição de placa\\n• Aguardar confecção\\n• Instalar placa', fillcolor = '#F8BBD0']
  
  etapa9 [label = 'ETAPA 9\\nVISTORIA DE SEGURANÇA\\nDO VEÍCULO\\n\\nCódigo: VIST-SEG-VEI\\nResponsável: Vistoriador\\n\\nVerificações:\\n• Chassi e Motor (numeração)\\n• Pneus (estado)\\n• Faróis e lanternas\\n• Freios\\n• Escapamento\\n• Itens de segurança', fillcolor = '#B3E5FC']
  
  decisao7 [label = 'Veículo aprovado\\nna vistoria?', shape = diamond, fillcolor = '#FFF9C4']
  
  regularizar [label = 'Orientar\\nregularização\\n(retornar)', shape = box, fillcolor = '#FF9800', fontcolor = 'white']
  
  etapa10 [label = 'ETAPA 10\\nVALIDAÇÃO FINAL DE\\nDOCUMENTAÇÃO\\n\\nCódigo: VALID-FINAL-DOC\\nResponsável: Agente de Liberação\\n\\nAções:\\n• Conferir processo PBDoc\\n• Verificar débitos quitados\\n• Confirmar restrições removidas\\n• Validar vistoria aprovada', fillcolor = '#C8E6C9']
  
  decisao8 [label = 'Documentação\\ncompleta?', shape = diamond, fillcolor = '#FFF9C4']
  
  complementar [label = 'Solicitar\\ncomplementação\\n(retornar)', shape = box, fillcolor = '#FF9800', fontcolor = 'white']
  
  etapa11 [label = 'ETAPA 11\\nEMISSÃO DE GUIA DE\\nLIBERAÇÃO\\n\\nCódigo: EMIS-GUIA-LIB\\nResponsável: Agente de Liberação\\n\\nAções:\\n• Gerar guia de liberação\\n• Imprimir termo de entrega\\n• Coletar assinatura\\n• Encaminhar para liberação física', fillcolor = '#BBDEFB']
  
  etapa12 [label = 'ETAPA 12\\nLIBERAÇÃO FÍSICA DO\\nVEÍCULO\\n\\nCódigo: LIBER-FIS-VEI\\nResponsável: Controle de Saída do Pátio\\n\\nAções:\\n• Localizar veículo no pátio\\n• Verificar condições físicas\\n• Entregar chave ao proprietário\\n• Acompanhar saída\\n• Registrar saída no sistema', fillcolor = '#C5CAE9']
  
  fim [label = 'FIM\\nVEÍCULO RETIRADO\\nCOM SUCESSO', shape = ellipse, fillcolor = '#4CAF50', fontcolor = 'white']
  
  # Conexões do fluxo
  inicio -> etapa1
  etapa1 -> decisao1
  decisao1 -> orientar [label = 'NÃO']
  decisao1 -> etapa2 [label = 'SIM']
  etapa2 -> etapa3
  etapa3 -> decisao2
  decisao2 -> etapa4 [label = 'SIM']
  decisao2 -> etapa5 [label = 'NÃO']
  etapa4 -> decisao3
  decisao3 -> informar [label = 'NÃO']
  decisao3 -> etapa5 [label = 'SIM']
  etapa5 -> decisao4
  decisao4 -> etapa6 [label = 'SIM']
  decisao4 -> etapa7 [label = 'NÃO']
  etapa6 -> decisao5
  decisao5 -> aguardar [label = 'NÃO']
  decisao5 -> etapa7 [label = 'SIM']
  etapa7 -> decisao6
  decisao6 -> etapa8 [label = 'NÃO']
  decisao6 -> etapa9 [label = 'SIM']
  etapa8 -> etapa9
  etapa9 -> decisao7
  decisao7 -> regularizar [label = 'NÃO']
  decisao7 -> etapa10 [label = 'SIM']
  etapa10 -> decisao8
  decisao8 -> complementar [label = 'NÃO']
  decisao8 -> etapa11 [label = 'SIM']
  etapa11 -> etapa12
  etapa12 -> fim
  
  # Retornos
  orientar -> etapa1 [style = dashed]
  aguardar -> etapa6 [style = dashed]
  regularizar -> etapa9 [style = dashed]
  complementar -> etapa10 [style = dashed]
}
")

# Visualizar organograma
print(organograma_coleta)

# Exportar para PNG
exportar_organograma(organograma_coleta, "organograma_coleta_liberacao_veiculos_detran_pb", 2400, 4000)

# ==============================================================================
# 5. MENSAGEM FINAL
# ==============================================================================

cat("\n")
cat("==============================================================================\n")
cat("✓ ORGANOGRAMAS GERADOS COM SUCESSO!\n")
cat("==============================================================================\n")
cat("Arquivos criados:\n")
cat("  1. organograma_antifraude_detran_pb.png\n")
cat("  2. organograma_coleta_liberacao_veiculos_detran_pb.png\n")
cat("\n")
cat("Autor: Diogo Rego | Estagiário | Estatística - UFPB\n")
cat("Instituição: DETRAN-PB | Governo do Estado da Paraíba\n")
cat("GitHub: https://github.com/Diogorego20/detran-policiamento-splas\n")
cat("==============================================================================\n")
