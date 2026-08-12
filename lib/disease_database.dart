class DiseaseDetails {
  final String symptoms;
  final String treatment;

  const DiseaseDetails({required this.symptoms, required this.treatment});
}

// Dicionário completo de doenças para todas as culturas do PLEASED
final Map<String, DiseaseDetails> diseaseDatabase = {
  
  // --- GERAL ---
  'Healthy': const DiseaseDetails(
    symptoms: 'A planta apresenta coloração normal e não possui sinais visíveis de doenças, fungos ou pragas.',
    treatment: 'Continue com a manutenção preventiva! Garanta boa irrigação, adubação equilibrada e boa circulação de ar.',
  ),

  // --- MAÇÃ (Apple) ---
  'Apple Scab': const DiseaseDetails(
    symptoms: 'Manchas verde-oliva a escuras com aspecto aveludado nas folhas e frutos. As folhas podem amarelar e cair prematuramente.',
    treatment: 'Remova folhas e frutos infectados. Aplique fungicidas específicos ou à base de cobre durante a primavera.',
  ),
  'Black Rot': const DiseaseDetails(
    symptoms: 'Manchas marrons circulares nas folhas que aumentam de tamanho. Nos frutos, causa apodrecimento escuro, anéis concêntricos e enrugamento.',
    treatment: 'Pode galhos mortos ou doentes durante o inverno. Faça o descarte adequado dos frutos mumificados.',
  ),
  'Cedar Apple Rust': const DiseaseDetails(
    symptoms: 'Manchas amarelas brilhantes na parte superior das folhas, que evoluem para estruturas em formato de pequenas copas na parte inferior.',
    treatment: 'Remova árvores hospedeiras alternativas (como juníperos/cedros próximos) se possível, e aplique fungicidas preventivos.',
  ),

  // --- CEREJA (Cherry) ---
  'Powdery Mildew': const DiseaseDetails(
    symptoms: 'Presença de um mofo ou revestimento esbranquiçado/acinzentado semelhante a pó nas folhas novas, brotos e frutos.',
    treatment: 'Melhore a insolação e a circulação de ar entre as plantas. Utilize fungicidas à base de enxofre ou bicarbonato.',
  ),

  // --- MILHO (Corn) ---
  'Cercospora Leaf Spot / Gray Leaf Spot': const DiseaseDetails(
    symptoms: 'Lesões longas, estreitas e retangulares de coloração cinza ou marrom claro que se alinham entre as nervuras das folhas.',
    treatment: 'Utilize sementes certificadas resistentes, faça a rotação de culturas e incorpore restos culturais no solo após a colheita.',
  ),
  'Common Rust': const DiseaseDetails(
    symptoms: 'Pústulas pequenas, ovais ou alongadas, de cor marrom-avermelhada a marrom-escura em ambas as superfícies das folhas.',
    treatment: 'Plante variedades tolerantes ou resistentes e evite o excesso de adubação nitrogenada.',
  ),
  'Northern Leaf Blight': const DiseaseDetails(
    symptoms: 'Lesões grandes, em formato de charuto ou elípticas, de cor cinza-esverdeada ou marrom, que reduzem drasticamente a área foliar.',
    treatment: 'Pratique a rotação de culturas e faça o manejo de restos de cultura da safra anterior.',
  ),

  // --- UVA (Grape) ---
// --- UVA (Grape) ---
  'Black Rot': const DiseaseDetails(
    symptoms: 'Manchas marrons circulares nas folhas que desenvolvem pequenos pontos pretos (frutificações do fungo). Nos frutos, causa podridão seca escura, fazendo a uva murchar e virar uma "múmia".',
    treatment: 'Remova e descarte bagas mumificadas e ramos infectados. Aplique fungicidas protetores preventivamente desde o início do brotamento até a pós-floração.',
  ),
  'Esca (Black Measles)': const DiseaseDetails(
    symptoms: 'Folhas com manchas amareladas ou avermelhadas entre as nervuras (aspecto de "tigre"), secando rapidamente. No tronco, pode causar podridão interna.',
    treatment: 'Pode os ramos afetados abaixo da área sintomática, proteja os cortes de poda com pasta cicatrizante e evite ferimentos desnecessários.',
  ),
  'Leaf Blight (Isariopsis Leaf Spot)': const DiseaseDetails(
    symptoms: 'Manchas angulares nas folhas que evoluem para áreas necrosadas, provocando desfolha precoce e enfraquecimento do vinhedo.',
    treatment: 'Aplique fungicidas protetores recomendados para videiras e mantenha o vinhedo bem podado para arejar a copa.',
  ),

  // --- PÊSSEGO (Peach) ---
  'Bacterial Spot': const DiseaseDetails(
    symptoms: 'Pequenas manchas encharcadas nas folhas que ficam roxas e depois caem, deixando o aspecto de "folha crivada" (furada). Também afeta os frutos.',
    treatment: 'Utilize variedades resistentes, evite irrigação excessiva por aspersão e aplique bactericidas à base de cobre no período de dormência.',
  ),

  // --- BATATA (Potato) ---
  'Early Blight': const DiseaseDetails(
    symptoms: 'Manchas marrons escuras a pretas nas folhas mais velhas, com anéis concêntricos formando um alvo.',
    treatment: 'Evite molhar as folhas durante a irrigação, faça rotação de culturas e utilize fungicidas protetores se necessário.',
  ),
  'Late Blight': const DiseaseDetails(
    symptoms: 'Manchas encharcadas escuras nas margens ou pontas das folhas que se espalham rapidamente, podendo exibir um mofo branco no verso em dias úmidos.',
    treatment: 'Destrua imediatamente plantas infectadas para evitar o contágio em massa e utilize fungicidas específicos sistêmicos/protetores.',
  ),

  // --- MORANGO (Strawberry) ---
  'Leaf Scorch': const DiseaseDetails(
    symptoms: 'Manchas roxas escuras ou marrons irregulares nas folhas que aumentam e se fundem, dando um aspecto de queimado à folhagem.',
    treatment: 'Remova e descarte as folhas severamente afetadas, evite adubação nitrogenada em excesso e garanta bom espaçamento.',
  ),

  // --- TOMATE (Tomato) ---
  'Leaf Mold': const DiseaseDetails(
    symptoms: 'Manchas amarelas pálidas na parte superior da folha e um crescimento aveludado de coloração oliva/marrom na parte inferior.',
    treatment: 'Reduza a umidade relativa do ar na estufa ou plantio, melhore a ventilação e espaçamento entre os pés de tomate.',
  ),
  'Septoria Leaf Spot': const DiseaseDetails(
    symptoms: 'Muitas pequenas manchas circulares com centros cinzentos ou brancos e bordas escuras. As folhas inferiores amarelam e caem.',
    treatment: 'Remova restos de plantas doentes, faça rotação de solo e aplique fungicidas preventivos.',
  ),
  'Spider Mites (Two-Spotted)': const DiseaseDetails(
    symptoms: 'Pequenos pontos amarelos ou brancos (clorose) nas folhas causados por sugadores, acompanhados de teias finas na parte inferior.',
    treatment: 'Utilize ácaros predadores naturais, aumente a umidade do ar ao redor da planta ou aplique acaricidas específicos se a infestação for alta.',
  ),
  'Target Spot': const DiseaseDetails(
    symptoms: 'Lesões circulares ou ovais com anéis concêntricos semelhantes a um alvo de tiro ao alvo, afetando folhas, caules e frutos.',
    treatment: 'Utilize cultivares resistentes e faça aplicações preventivas de fungicidas em períodos chuvosos.',
  ),
  'Tomato Mosaic Virus': const DiseaseDetails(
    symptoms: 'Folhas com padrão quadriculado ou mosaico em tons de verde claro e escuro, frequentemente deformadas, estreitas ou retorcidas.',
    treatment: 'Não há cura química para vírus. Remova e queime as plantas infectadas imediatamente. Lave bem as mãos e ferramentas ao manusear as plantas.',
  ),
  'Tomato Yellow Leaf Curl Virus': const DiseaseDetails(
    symptoms: 'Folhas severamente enroladas para cima, amareladas nas bordas, com crescimento atrofiado e redução drástica na produção de frutos.',
    treatment: 'Controle a população de mosquitos-branca (vetores do vírus) utilizando telas de proteção, armadilhas amarelas ou inseticidas adequados.',
  ),

  // --- PADRÃO DE SEGURANÇA ---
  'Default': const DiseaseDetails(
    symptoms: 'Sintomas específicos identificados pela rede neural, mas sem descrição textual detalhada cadastrada.',
    treatment: 'Recomenda-se isolar a planta afetada e consultar um agrônomo ou técnico agrícola para uma avaliação presencial.',
  ),
};