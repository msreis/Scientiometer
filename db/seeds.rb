# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
################################################################################
# Keep
################################################################################
## PQ level or foundation role ###
pq_levels_roles = [
  ['I', ["pesquisador"]],
  ['II', ["pesquisador"]],
  ['III', ["pesquisador"]],
  ['IV', ["pesquisador"]],
  ['V', ["pesquisador"]],
  ['VI', ["pesquisador"]],
  ['Agente de apoio à pesquisa científica e tecnológica I', ["estatutário"]],
  ['Agente de apoio à pesquisa científica e tecnológica II', ["estatutário"]],
  ['Agente de apoio à pesquisa científica e tecnológica III', ["estatutário"]],
  ['Agente de apoio à pesquisa científica e tecnológica IV', ["estatutário"]],
  ['Agente de apoio à pesquisa científica e tecnológica V', ["estatutário"]],
  ['Agente de apoio à pesquisa científica e tecnológica VI', ["estatutário"]],
  ['Agente de saúde', ["estatutário"]],
  ['Analista administrativo', ["pesquisador"]],
  ['Analista administrativo junior', ["fundação"]],
  ['Analista administrativo pleno', ["fundação"]],
  ['Analista administrativo senior', ["fundação"]],
  ['Analista de laboratório de desenvolvimento I', ["fundação"]],
  ['Analista de laboratório de desenvolvimento II', ["fundação"]],
  ['Analista de laboratório de desenvolvimento III', ["fundação"]],
  ['Analista de processos', ["fundação"]],
  ['Analista de sistemas junior', ["fundação"]],
  ['Analista de sistemas pleno', ["fundação"]],
  ['Analista de sistemas senior', ["fundação"]],
  ['Assistente administrativo', ["pesquisador", "fundação"]],
  ['Assistente de organização e pesquisa', ["fundação"]],
  ['Assistente executivo', ["fundação"]],
  ['Assistente técnico de apoio à pesquisa científica e tecnológica I', ["estatutário"]],
  ['Assistente técnico de apoio à pesquisa científica e tecnológica II', ["estatutário"]],
  ['Assistente técnico de apoio à pesquisa científica e tecnológica III', ["estatutário"]],
  ['Assistente técnico de apoio à pesquisa científica e tecnológica IV', ["estatutário"]],
  ['Assistente técnico de apoio à pesquisa científica e tecnológica V', ["estatutário"]],
  ['Assistente técnico de apoio à pesquisa científica e tecnológica VI', ["estatutário"]],
  ['Auxiliar administrativo', ["pesquisador", "estatutário"]],
  ['Auxiliar de apoio à pesquisa científica e tecnológica I', ["estatutário"]],
  ['Auxiliar de apoio à pesquisa científica e tecnológica II', ["estatutário"]],
  ['Auxiliar de laboratório', ["estatutário"]],
  ['Auxiliar de laboratório I', ["fundação"]],
  ['Auxiliar de limpeza', ["fundação"]],
  ['Auxiliar de produção', ["fundação"]],
  ['Auxiliar de saúde', ["estatutário"]],
  ['Auxiliar de serviços gerais', ["estatutário"]],
  ['Bioinformata', ["pesquisador", "fundação"]],
  ['Biólogo', ["fundação"]],
  ['Biotecnologista', ["fundação"]],
  ['Chefe I', ["estatutário"]],
  ['Colaborador', ["pesquisador"]],
  ['Coordenador', ["fundação"]],
  ['Coordenador de produção', ["fundação"]],
  ['Educador', ["fundação"]],
  ['Especialista de laboratório', ["fundação"]],
  ['Gerente de produção', ["fundação"]],
  ['Gestor de projetos', ["pesquisador", "estatutário"]],
  ['Jovem aprendiz', ["fundação"]],
  ['Liderança científica', ["pesquisador"]],
  ['Médico', ["estatutário"]],
  ['Médico Veterinário', ["fundação"]],
  ['Oficial administrativo', ["estatutário"]],
  ['Oficial de apoio à pesquisa científica e tecnológica I', ["estatutário"]],
  ['Oficial de apoio à pesquisa científica e tecnológica II', ["estatutário"]],
  ['Oficial de apoio à pesquisa científica e tecnológica III', ["estatutário"]],
  ['Oficial de apoio à pesquisa científica e tecnológica IV', ["estatutário"]],
  ['Oficial de apoio à pesquisa científica e tecnológica V', ["estatutário"]],
  ['Oficial de apoio à pesquisa científica e tecnológica VI', ["estatutário"]],
  ['Oficial de serviços gerais', ["estatutário"]],
  ['Oficial operacional', ["estatutário"]],
  ['Pesquisador Fundação Butantan I', ["pesquisador"]],
  ['Pesquisador Fundação Butantan II', ["pesquisador"]],
  ['Pesquisador Fundação Butantan III', ["pesquisador"]],
  ['Secretária bilíngue', ["fundação"]],
  ['Servente', ["fundação"]],
  ['Supervisor', ["fundação"]],
  ['Supervisor de produção', ["pesquisador", "fundação"]],
  ['Técnico de apoio à pesquisa científica e tecnológica I', ["estatutário"]],
  ['Técnico de apoio à pesquisa científica e tecnológica II', ["estatutário"]],
  ['Técnico de apoio à pesquisa científica e tecnológica III', ["estatutário"]],
  ['Técnico de apoio à pesquisa científica e tecnológica IV', ["estatutário"]],
  ['Técnico de apoio à pesquisa científica e tecnológica V', ["estatutário"]],
  ['Técnico de apoio à pesquisa científica e tecnológica VI', ["estatutário"]],
  ['Técnico de laboratório', ["estatutário"]],
  ['Técnico de laboratório I', ["fundação"]],
  ['Técnico de microscopia', ["fundação"]],
  ['Técnico de produção I', ["fundação"]],
  ['Técnico de produção II', ["fundação"]],
  ['Técnico em educação', ["fundação"]],
  ['Técnico em exposição', ["fundação"]],
  ['Tecnologista de laboratório de artrópodes I', ["fundação"]],
  ['Tecnologista de laboratório de desenvolvimento I', ["pesquisador", "fundação"]],
  ['Tecnologista de laboratório de desenvolvimento II', ["pesquisador", "fundação"]],
  ['Tecnologista de laboratório de desenvolvimento III', ["pesquisador", "fundação"]],
  ['Tecnologista de produção I', ["fundação"]],
  ['Tecnologista de produção II', ["fundação"]],
  ['Tecnologista de produção III', ["fundação"]],
  ['Veterinário', ["fundação"]],
  ['Outro', ["pesquisador", "fundação", "estatutário"]]
]

pq_levels_roles.each do |role|
  RoleFoundationLevel.create(description: role[0], categories: role[1])
end

## Grant agencies
agencies = [
  'BIOTICK',
  'BNDES',
  'CAPES',
  'CNPq',
  'Conciencias',
  'CONCITEC',
  'Convênio',
  'FAPESP',
  'FAPESP/GSK',
  'Fundação Butantan',
  'Fundação Butantan/Convênio',
  'FUNDAP',
  'GSK',
  'PAP',
  'Serrapilheira'
]

agencies.each do |agency|
  FundingAgency.create(name: agency)
end

## Instituions
institutions = [
  'CCD – SSESP',
  'EP – USP',
  'FCF – USP',
  'FM – USP',
  'FMU',
  'FMVZ – USP',
  'IB – USP',
  'IBU',
  'IBU / IPT / USP',
  'ICB – USP',
  'IME – USP',
  'IMT – USP',
  'IP – USP',
  'IQ – USP',
  'Museu Nacional – UFRJ',
  'UESC',
  'UFSM',
  'UFT',
  'UNESP',
  'UNICAMP',
  'UNIFESP',
  'UNIP',
  'UNISA',
  'USP',
  'Outra'
]

institutions.each do |inst|
  Institution.create(name: inst)
end

####

titles = [
  ['Ensino fundamental', false],
  ['Ensino médio', false],
  ['Ensino médio técnico', false],
  ['Graduação', true],
  ['Mestrado', true],
  ['Doutorado', true]
]
titles.each do |title|
  Title.create(name: title[0], is_researcher: title[1])
end

####

degrees = [
  'Aperfeiçoamento (inclui PAP)',
  'Iniciação Científica',
  'Mestrado',
  'Doutorado',
  'Doutorado direto',
  'Pós-doutorado',
  'Treinamento Técnico 1',
  'Treinamento Técnico 2',
  'Treinamento Técnico 3',
  'Treinamento Técnico 4',
  'Treinamento Técnico 4A',
  'Treinamento Técnico 5'
]

degrees.each do |degree|
  AdvisementDegree.create(degree: degree)
end

######

productivity_grant_types = [
  '1A',
  '1B',
  '1C',
  '1D',
  '2',
  'SR',
  'Fundação'
]

productivity_grant_types.each do |type|
  ProductivityGrantType.create(name: type)
end

####

qualis = %w[
  A1
  A2
  B1
  B2
  B3
  B4
  B5
  C
]

qualis.each do |level|
  Qualis.create(qualis: level)
end

######

PostDocType.create([{ postdoc_type: 'Nacional' }, { postdoc_type: 'No Exterior' }, { postdoc_type: 'Não Há' }])

######

CollaborationType.create([{ collaboration: 'Nacional' }, { collaboration: 'Internacional' }])

######

LineOfResearch.create([{ name: 'Básica' }, { name: 'Aplicada' }, { name: 'Translacional' }])

######

roles = [
  'Apresentação de pôster',
  'Comunicação oral',
  'Coordenação de evento',
  'Coordenação de seção (chair)',
  'Mesa Redonda',
  'Palestra magna'
]

roles.each do |role|
  CongressRole.create(role: role)
end

#####
postgraduate_programs = [
  'Anatomia dos Animais Domésticos e Silvestres',
  'Biodiversidade Animal',
  'Biologia Estrutural e Funcional',
  'Biologia Molecular',
  'Biologia Animal',
  'Biologia da Relação Patógeno-Hospedeiro',
  'Bioquímica',
  'Biotecnologia e Bioprocessos',
  'Ciências',
  'Ciências Biológicas – Zoologia',
  'Ciências da Computação',
  'Ciências Médicas',
  'Farmácia',
  'Farmacologia',
  'Fisiologia Humana',
  'Fisiopatologia Experimental',
  'Genética e Biologia Evolutiva',
  'Imunologia',
  'Interunidades em Bioinformática',
  'Interunidades em Biotecnologia',
  'Medicina e Bem-estar Animal',
  'Medicina Tropical',
  'Medicina Veterinária',
  'Microbiologia',
  'Microbiologia e Imunologia',
  'Neurociência e Comportamento',
  'Patologia Experimental e Comparada',
  'Pesquisas Laboratoriais em Saúde Pública',
  'Toxinologia',
  'Zoologia',
  'Outro'
].freeze

postgraduate_programs.each do |prog|
  PostgraduateProgram.create(name: prog)
end

laboratories = [
  'Laboratório de Artrópodes',
  'Laboratório de Bacteriologia',
  'Laboratório de Biologia Celular',
  'Laboratório de Bioquímica e Biofísica',
  'Laboratório de Ciclo Celular',
  'Laboratório de Coleções Zoológicas',
  'Laboratório de Desenvolvimento de Vacinas',
  'Laboratório de Ecologia e Evolução',
  'Laboratório de Farmacologia',
  'Laboratório de Fisiopatologia',
  'Laboratório de Herpetologia',
  'Laboratório de Imunogenética',
  'Laboratório de Imunopatologia',
  'Laboratório de Parasitologia',
  'Laboratório de Toxinologia Aplicada'
]
div = LaboratoryDivision.create(name: 'Centro de Desenvolvimento Científico')
laboratories.each do |lab|
  Laboratory.create(name: lab, laboratory_division: div)
end

#####

GrantParticipationType.create([{ name: 'Coordenador' }, { name: 'Pesquisador Principal' }, { name: 'Pesquisador Associado' }])

#####

project_type = [
  'Auxílio Regular',
  'Projeto Temático',
  'Jovem Pesquisador',
  'CEPID',
  'Parceria com iniciativa privada',
  'Universal',
  'Outro'
]

project_type.each do |project|
  GrantProjectType.create(name: project)
end

#####

ActivityType.create([
                      { name: 'Institucional' },
                      { name: 'Cultural' },
                      { name: 'Inovação ou Translacional' },
                      { name: 'Prestação de Serviço' }
                    ])

#####

institucional_sub_activitiy_types = [
  'Assessoria externa (ad hoc FAPESP e outras)',
  'Comissão ABNT - Grupo de trabalho em biotecnologia (membro)',
  'Comissão ABNT - Grupo de trabalho em biotecnologia (presidente)',
  'Comissão científica externa (membro)',
  'Comissão científica externa (presidente)',
  'Comissão da gripe espanhola (membro)',
  'Comissão da gripe espanhola (presidente)',
  'Comissão de acervos (membro)',
  'Comissão de acervos (presidente)',
  'Comissão de concessão de bolsas PIBIC/PIBITI (membro)',
  'Comissão de concessão de bolsas PIBIC/PIBITI (presidente)',
  'Comissão de estágio do IBU (membro)',
  'Comissão de estágio do IBU (presidente)',
  'Comissão de ética externa (membro)',
  'Comissão de ética externa (presidente)',
  'Comissão de pós-graduação – Biotecnologia e Bioprocessos IBU (membro)',
  'Comissão de pós-graduação – Biotecnologia e Bioprocessos IBU (presidente)',
  'Comissão de pós-graduação – Interunidades em Biotecnologia (membro)',
  'Comissão de pós-graduação – Interunidades em Biotecnologia (presidente)',
  'Comissão de pós-graduação – outra (membro)',
  'Comissão de pós-graduação – outra (presidente)',
  'Comissão de pós-graduação – Toxinologia IBU (membro)',
  'Comissão de pós-graduação – Toxinologia IBU (presidente)',
  'Comissão de resíduos (membro)',
  'Comissão de resíduos (presidente)',
  'Comissão de seleção de estudantes (membro)',
  'Comissão de seleção de estudantes (presidente)',
  'Comissão de seminários do IBU (membro)',
  'Comissão de seminários do IBU (presidente)',
  'Comissão do banco de tecidos (membro)',
  'Comissão do banco de tecidos (presidente)',
  'Comissão do relatório anual de produtividade e captação de recursos (membro)',
  'Comissão do relatório anual de produtividade e captação de recursos (presidente)',
  'Comissão interna de Biossegurança – CiBio (membro)',
  'Comissão interna de Biossegurança – CiBio (presidente)',
  'Comissão organizadora da RCA (coordenador)',
  'Comissão organizadora da RCA (membro)',
  'Comissão organizadora de outros eventos (coordenador)',
  'Comissão organizadora de outros eventos (membro)',
  'Comissão Permanente de Normatização em Biodiversidade – SisGen (membro)',
  'Comissão Permanente de Normatização em Biodiversidade – SisGen (presidente)',
  'Comissão Permanente do Regime de Tempo Integral – CPRTI (membro)',
  'Comissão Permanente do Regime de Tempo Integral – CPRTI (presidente)',
  'Comissão Técnica Nacional de Biossegurança (membro)',
  'Comissão Técnica Nacional de Biossegurança (presidente)',
  'Comitê de ética no uso de animais – CEUA (membro)',
  'Comitê de ética no uso de animais – CEUA (presidente)',
  'Comitê gestor dos equipamentos multi-usuários (membro)',
  'Comitê gestor dos equipamentos multi-usuários (presidente)',
  'Conselho de cultura (membro)',
  'Conselho de cultura (presidente)',
  'Conselho de pesquisa (membro)',
  'Conselho de pesquisa (presidente)',
  'Conselho deliberativo da Associação dos Pesquisadores Científicos do Estado de São Paulo – ApqC (membro)',
  'Conselho deliberativo da Associação dos Pesquisadores Científicos do Estado de São Paulo – ApqC (presidente)',
  'Conselho Deliberativo de Curadoria Coleções Zoológicas do Instituto Butantan (membro)',
  'Conselho Deliberativo de Curadoria Coleções Zoológicas do Instituto Butantan (presidente)',
  'Conselho tecnológico e produção (membro)',
  'Conselho tecnológico e produção (presidente)',
  'Coordenação de CEPID',
  'Coordenação de curso (suplente)',
  'Coordenação de curso (titular)',
  'Coordenação de especialização (suplente)',
  'Coordenação de especialização (titular)',
  'Coordenação de plataforma multi-usuários',
  'Coordenação de Projeto Temático',
  'Curadoria de coleção',
  'Diretor de Área',
  'Diretor de Divisão',
  'Diretor de Laboratório',
  'Diretor substituto de Área',
  'Diretor substituto de Divisão',
  'Diretor substituto de Laboratório',
  'Gestão de Laboratório',
  'Grupo de trabalho contra a febre amarela (membro)',
  'Grupo de trabalho contra a febre amarela (presidente)',
  'Participação em banca de trabalho de conclusão de curso',
  'Participação em reunião',
  'Participação em banca de contratação',
  'Revisão de artigos enviados para publicação em periódicos',
  'Outra'
]

cultural_sub_activity_types = [
  'Demonstrações de extração de veneno',
  'Divulgação científica em eventos',
  'Divulgação científica na internet e em outros meios eletrônicos',
  'Entrevista para rádio, TV ou jornal impresso',
  'Montagem/organização de exposição',
  'Montagem/organização de produção teatral',
  'Organização da Semana de Ciência e Tecnologia',
  'Organização de atividades de circuito de maior idade',
  'Organização de atividades de divulgação científica em escolas',
  'Organização de atividades de semana de férias',
  'Organização de atividades no Museu Biológico',
  'Organização de curso educativo de extensão',
  'Organização de feira de livro',
  'Organização de visita escolar a laboratório',
  'Pint of Science, Café Científico e eventos similares',
  'Palestra de difusão científica',
  'Produção de artigos de divulgação científica',
  'Produção de material impresso de divulgação científica',
  'Outra'
]

inovacao_or_translacional_sub_activity_types = [
  'Coordenação de centro de inovação',
  'Coordenação de desenvolvimento de vacinas',
  'Coordenação de plataforma de ensaios clínicos',
  'Coordenação de programa de pós-graduação em inovação',
  'Coordenação de projeto de inovação',
  'Coordenação de testes clínicos',
  'Criação de software ou banco de dados',
  'Desenvolvimento de processos',
  'Desenvolvimento de produtos',
  'Elaboração de solicitação de patente',
  'Gestão de centro de inovação',
  'Gestão de projeto de inovação',
  'Participação em business model canvas',
  'Participação em desenvolvimento de vacinas',
  'Participação em palestras e cursos sobre  inovação',
  'Participação em testes clínicos',
  'Participação em transferência de tecnologia',
  'Outra'
]

prestacao_sub_activity_types = [
  'Coleta de serpentes',
  'Consultoria sobre metodologias',
  'Coordenação de recepção de animais',
  'Coordenação de revisões de listas de espécies',
  'Criação e manutenção de artrópodes',
  'Criação e manutenção de répteis',
  'Elaboração de relatórios científicos aos órgãos reguladores',
  'Extração de veneno',
  'Identificação de espécies animais',
  'Identificação de espécies químicas',
  'Necropsia de artrópodes',
  'Necropsia de répteis',
  'Operação de equipamento multi-usuário',
  'Preparação e análise de pools de veneno',
  'Produção e purificação de proteínas recombinantes',
  'Responsável técnico de criadouro',
  'Revisão de manuscrito de artigo científico externo ao Butantan (ainda não enviado para publicação)',
  'Sequenciamento de nucleotídeos',
  'Sequenciamento de peptídeos',
  'Tratamento clínico/cirúrgico de animais',
  'Treinamento de identificação e manejo de serpentes para público externo'
]

institucional_sub_activitiy_types.each do |sub|
  SubActivityType.create(name: sub, activity_type_id: 1)
end

cultural_sub_activity_types.each do |sub|
  SubActivityType.create(name: sub, activity_type_id: 2)
end

inovacao_or_translacional_sub_activity_types.each do |sub|
  SubActivityType.create(name: sub, activity_type_id: 3)
end

prestacao_sub_activity_types.each do |sub|
  SubActivityType.create(name: sub, activity_type_id: 4)
end

#####

CourseClassification.create([{ classification: 'Difusão' }, { classification: 'Extensão Universitária' }])

####

CourseDegree.create([{ degree: 'Mestrado' }, { degree: 'Doutorado' }])

####

CoordinationDegree.create([{ degree: 'Público Geral' }, { degree: 'Graduandos' }, { degree: 'Pós-Graduandos' }])

####

Profile.create(name: 'Pesquisador', description: 'pesquisador', access_level: '1')
Profile.create(name: 'Diretor de Laboratório', description: 'diretor de laboratório', access_level: '2')
Profile.create(name: 'Diretor de Divisão', description: 'diretor de divisão', access_level: '3')
Profile.create(name: 'Administrador', description: 'administrador de dados do sistema', access_level: '4')

###

approval_actions = [
  'Submissão',
  'Aprovação',
  'Reprovação'
]

approval_actions.each do |name|
  ApprovalAction.create(name: name)
end

####

grant_currentnesses = [
  'Novo',
  'Vigente',
  'Extensão'
]

grant_currentnesses.each do |current|
  GrantCurrentness.create(name: current)
end