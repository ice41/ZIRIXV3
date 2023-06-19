-- Groups by Ice41 / Andrade -- Rbrasil-2.4
groups = {}

groups.masterGroup = 'manager'

groups.list = {

    -- [ Inicio ] Judiciário

    ['judiciario'] = {
        _config = {
            title = 'Membro Judiciário',
            gtype = 'job'
        },
        'judiciario.permissao'
    },

    ['juiz'] = {
        _config = {
            title = 'Juiz(a)',
            gtype = 'job'
        },
        'juiz.permissao',
        'judiciario.permissao'
    },

    ['procurador'] = {
        _config = {
            title = 'Procurador(a)',
            gtype = 'job'
        },
        'procurador.permissao',
        'judiciario.permissao'
    },

    ['promotor'] = {
        _config = {
            title = 'Promotor(a)',
            gtype = 'job'
        },
        'promotor.permissao',
        'judiciario.permissao'
    },

    ['defensor'] = {
        _config = {
            title = 'Defensor(a) Público',
            gtype = 'job'
        },
        'defensor.permissao',
        'judiciario.permissao'
    },

    ['advogado'] = {
        _config = {
            title = 'Advogado(a)',
            gtype = 'adv'
        },
        'advogado.permissao',
        'judiciario.permissao'
    },

    -- [ FIM ] Judiciário

    -- [ Noticiario ] --------------------------------

    ['news'] = {
        _config = {
            title = 'Weazel News',
            gtype = 'job'
        },
        'news.permissao'
    },

    ['news-diretor'] = {
        _config = {
            title = 'Weazel News Diretor',
            gtype = 'job'
        },
        'news-diretor.permissao',
        'news.permissao'
    },

    ['news-editor'] = {
        _config = {
            title = 'Weazel News editor',
            gtype = 'job'
        },
        'news-estagiario.permissao',
        'news.permissao'
    },

    ['news-redator'] = {
        _config = {
            title = 'Weazel News Redator',
            gtype = 'job'
        },
        'news-redator.permissao',
        'news.permissao'
    },

    ['news-jornalista'] = {
        _config = {
            title = 'Weazel News Jornalista',
            gtype = 'job'
        },
        'news-jornalista.permissao',
        'news.permissao'
    },

    ['news-estagiario'] = {
        _config = {
            title = 'Weazel News Estagiario',
            gtype = 'job'
        },
        'news-estagiario.permissao',
        'news.permissao'
    },

    -- [ Noticiario ] --------------------------------

    -- Sets Policiais -----------------------------------------

    -- [ Inicio ] Set Policia Global

    ['policia'] = {
        _config = {
            title = 'Policia',
            gtype = 'job'
        },
        'policia.permissao'
    },

    ['paisana-policia'] = {
        _config = {
            title = 'Policia Paisana',
            gtype = 'job'
        },
        'paisana-policia.permissao'
    },

    ['policia-patrulha'] = {
        _config = {
            title = 'Em Patrulha',
            gtype = 'patrulha'
        },
        'policia-patrulha.permissao'
    },

    -- [ FIM ] Set Policia Global

    -- [ PMESP Inicio ] -------------------------------

    ['cmd-geral-pmesp'] = {
        _config = {
            title = 'Comandante Geral PMESP',
            gtype = 'job'
        },
        'cmd-geral-pmesp.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['cmd-geral-pmesp-apaisana'] = {
        _config = {
            title = 'Comandante Geral PMESP apaisana',
            gtype = 'job'
        },
        'cmd-geral-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['coronel-pmesp'] = {
        _config = {
            title = 'Coronel PMESP',
            gtype = 'job'
        },
        'coronel-pmesp.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['coronel-pmesp-apaisana'] = {
        _config = {
            title = 'Coronel PMESP apaisana',
            gtype = 'job'
        },
        'coronel-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['major-pmesp'] = {
        _config = {
            title = 'Major PMESP',
            gtype = 'job'
        },
        'major-pmesp.permissao',
        'inspetor.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['major-pmesp-apaisana'] = {
        _config = {
            title = 'Major PMESP apaisana',
            gtype = 'job'
        },
        'major-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['capitao-pmesp'] = {
        _config = {
            title = 'Capitão PMESP',
            gtype = 'job'
        },
        'capitao-pmesp.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['capitao-pmesp-apaisana'] = {
        _config = {
            title = 'Capitão PMESP apaisana',
            gtype = 'job'
        },
        'capitao-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tenente-pmesp'] = {
        _config = {
            title = 'Tenente PMESP',
            gtype = 'job'
        },
        'tenente-pmesp.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['tenente-pmesp-apaisana'] = {
        _config = {
            title = 'Tenente PMESP apaisana',
            gtype = 'job'
        },
        'tenente-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['primeiro-sgt-pmesp'] = {
        _config = {
            title = '1º SGT PMESP',
            gtype = 'job'
        },
        'primeiro-sgt-pmesp.permissao',
        'policia.permissao',
        'pmesp.permissao',
    },
    ['primeiro-sgt-pmesp-apaisana'] = {
        _config = {
            title = '1º SGT PMESP apaisana',
            gtype = 'job'
        },
        'primeiro-sgt-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['segundo-sgt-pmesp'] = {
        _config = {
            title = '2º SGT PMESP',
            gtype = 'job'
        },
        'segundo-sgt-pmesp.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao'
    },
    ['segundo-sgt-pmesp-apaisana'] = {
        _config = {
            title = '2º SGT PMESP apaisana',
            gtype = 'job'
        },
        'segundo-sgt-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['terceiro-sgt-pmesp'] = {
        _config = {
            title = '3º SGT PMESP',
            gtype = 'job'
        },
        'terceiro-sgt-pmesp.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['terceiro-sgt-pmesp-apaisana'] = {
        _config = {
            title = '3º SGT PMESP apaisana',
            gtype = 'job'
        },
        'terceiro-sgt-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['cabo-pmesp'] = {
        _config = {
            title = 'Cabo PMESP',
            gtype = 'job'
        },
        'cabo-pmesp.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['cabo-pmesp-apaisana'] = {
        _config = {
            title = 'Cabo PMESP apaisana',
            gtype = 'job'
        },
        'cabo-pmesp-apaisana.permissao',
        'paisana-policia.permissao',

    },

    ['soldado-pmesp'] = {
        _config = {
            title = 'Soldado PMESP',
            gtype = 'job'
        },
        'soldado-pmesp.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['soldado-pmesp-apaisana'] = {
        _config = {
            title = 'Soldado PMESP apaisana',
            gtype = 'job'
        },
        'soldado-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['recruta-pmesp'] = {
        _config = {
            title = 'Recruta PMESP',
            gtype = 'job'
        },
        'recruta-pmesp.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'pmesp.permissao',
    },
    ['recruta-pmesp-apaisana'] = {
        _config = {
            title = 'Recruta PMESP Paisana',
            gtype = 'job'
        },
        'recruta-pmesp-apaisana.permissao',
        'paisana-policia.permissao',
    },

    -- [ PMESP FIM ] -------------------------------

    -- [ PCSP Inicio ] -----------------------------

    ['delegado-civil'] = {
        _config = {
            title = 'Delegado PCESP',
            gtype = 'job'
        },
        'delegado-civil.permissao',
        'policia.permissao',
        'porte.permissao',
        'civil.permissao'
    },
    ['delegado-civil-apaisana'] = {
        _config = {
            title = 'Delegado Apaisana PCESP',
            gtype = 'job'
        },
        'delegado-civil-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['delegado-auxiliar-civil'] = {
        _config = {
            title = 'Delegado Auxiliar PCESP',
            gtype = 'job'
        },
        'delegado-auxiliar-civil.permissao',
        'policia.permissao',
        'civil.permissao',
        'porte.permissao',
    },
    ['delegado-auxiliar-civil-apaisana'] = {
        _config = {
            title = 'Delegado Aux Apaisana PCESP',
            gtype = 'job'
        },
        'delegado-auxiliar-civil-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['legista-civil'] = {
        _config = {
            title = 'Legista PCESP',
            gtype = 'job'
        },
        'legista-civil.permissao',
        'policia.permissao',
        'civil.permissao',
        'hospital.permissao',
    },
    ['legista-civil-apaisana'] = {
        _config = {
            title = 'Legista Apaisana PCESP',
            gtype = 'job'
        },
        'legista-civil-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['escrivao-civil'] = {
        _config = {
            title = 'Escrivão PCESP',
            gtype = 'job'
        },
        'escrivao-civil.permissao',
        'policia.permissao',
        'civil.permissao',
        'porte.permissao',
    },
    ['escrivao-civil-apaisana'] = {
        _config = {
            title = 'Escrivão Apaisana PCESP',
            gtype = 'job'
        },
        'escrivao-civil-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['investigador-civil'] = {
        _config = {
            title = 'Investigador PCESP',
            gtype = 'job'
        },
        'investigador-civil.permissao',
        'policia.permissao',
        'civil.permissao',
    },
    ['investigador-civil-apaisana'] = {
        _config = {
            title = 'Investigador Apasiana PCESP',
            gtype = 'job'
        },
        'investigador-civil-apasiana.permissao',
    },

    ['goe-civil'] = {
        _config = {
            title = 'GOE PCESP',
            gtype = 'job'
        },
        'goe-civil.permissao',
        'policia.permissao',
        'civil.permissao'
    },
    ['goe-civil-apaisana'] = {
        _config = {
            title = 'GOE Apaisana PCESP',
            gtype = 'job'
        },
        'goe-civil-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['agente-civil'] = {
        _config = {
            title = 'Agente PCESP',
            gtype = 'job'
        },
        'agente-civil.permissao',
        'policia.permissao',
        'civil.permissao'
    },
    ['agente-civil-apaisana'] = {
        _config = {
            title = 'Agente Apaisana PCESP',
            gtype = 'job'
        },
        'agente-civil-apaisana.permissao',
        'paisana-policia.permissao'
    },

    -- [ ROTA - Rondas Ostensivas Tobias de Aguiar - Inicio ] ------------

    ['rota-coronel'] = {
        _config = {
            title = 'Coronel ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'rota-coronel.permissao',
    },
    ['rota-coronel-apaisana'] = {
        _config = {
            title = 'Coronel ROTA apaisana',
            gtype = 'job'
        },
        'rota-coronel-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-ten-coronel'] = {
        _config = {
            title = 'Tenente Coronel ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'rota-ten-coronel.permissao',
    },
    ['rota-ten-coronel-apaisana'] = {
        _config = {
            title = 'Tenente Coronel ROTA apaisana',
            gtype = 'job'
        },
        'rota-ten-coronel-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-major'] = {
        _config = {
            title = 'Major ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'rota-major.permissao',
    },
    ['rota-major-apaisana'] = {
        _config = {
            title = 'Major ROTA apaisana',
            gtype = 'job'
        },
        'rota-major-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-capitao'] = {
        _config = {
            title = 'Capitao ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rota-capitao.permissao',
    },
    ['rota-capitao-apaisana'] = {
        _config = {
            title = 'Capitao ROTA apaisana',
            gtype = 'job'
        },
        'rota-capitao-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-1tenet'] = {
        _config = {
            title = '1º Tenente ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rota-1tenet.permissao',
    },
    ['rota-1tenet-apaisana'] = {
        _config = {
            title = '1º Tenente ROTA apaisana',
            gtype = 'job'
        },
        'rota-1tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-2tenet'] = {
        _config = {
            title = '2º Tenente ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rota-2tenet.permissao',
    },
    ['rota-2tenet-apaisana'] = {
        _config = {
            title = '2º Tenente ROTA apaisana',
            gtype = 'job'
        },
        'rota-2tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-subtenet'] = {
        _config = {
            title = 'Sub Tenente ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rota-subtenet.permissao',
    },
    ['rota-subtenet-apaisana'] = {
        _config = {
            title = 'Sub Tenente ROTA apaisana',
            gtype = 'job'
        },
        'rota-subtenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-sagento1'] = {
        _config = {
            title = '1º SGT ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rota-sagento1.permissao',
    },
    ['rota-sagento1-apaisana'] = {
        _config = {
            title = '1º SGT ROTA apaisana',
            gtype = 'job'
        },
        'rota-sagento1-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-sagento2'] = {
        _config = {
            title = '2º SGT ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rota-sagento2.permissao',
    },
    ['rota-sagento2-apaisana'] = {
        _config = {
            title = '2º SGT ROTA apaisana',
            gtype = 'job'
        },
        'rota-sagento2-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rota-sagento3'] = {
        _config = {
            title = '3º SGT ROTA',
            gtype = 'job'
        },
        'rota.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rota-sagento3.permissao',
    },
    ['rota-sagento3-apaisana'] = {
        _config = {
            title = '3º SGT ROTA apaisana',
            gtype = 'job'
        },
        'rota-sagento3-apaisana.permissao',
        'paisana-policia.permissao',
    },

    -- [ ROTA - Rondas Ostensivas Tobias de Aguiar - FIM ] ------------

    -- [ ROCAM - Ronda Ostensiva com Apoio de Motocicletas - Inicio ] ------------

    ['rocam-coronel'] = {
        _config = {
            title = 'Coronel ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-coronel.permissao',
    },
    ['rocam-coronel-paisana'] = {
        _config = {
            title = 'Coronel ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-coronel-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-ten-coronel'] = {
        _config = {
            title = 'Tenente Coronel ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-ten-coronel.permissao',
    },
    ['rocam-ten-coronel-apaisana'] = {
        _config = {
            title = 'Tenente Coronel ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-ten-coronel-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-major'] = {
        _config = {
            title = 'Major ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-major.permissao',
    },
    ['rocam-major-apaisana'] = {
        _config = {
            title = 'Major ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-major-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-capitao'] = {
        _config = {
            title = 'Capitao ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-capitao.permissao',
    },
    ['rocam-capitao-apaisana'] = {
        _config = {
            title = 'Capitao ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-capitao-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-1tenet'] = {
        _config = {
            title = '1º Tenente ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-1tenet.permissao',
    },
    ['rocam-1tenet-apaisana'] = {
        _config = {
            title = '1º Tenente ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-1tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-2tenet'] = {
        _config = {
            title = '2º Tenente ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-2tenet.permissao',
    },
    ['rocam-2tenet-apaisana'] = {
        _config = {
            title = '2º Tenente ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-2tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-subtenet'] = {
        _config = {
            title = 'Sub Tenente ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-subtenet.permissao',
    },
    ['rocam-subtenet-apaisana'] = {
        _config = {
            title = 'Sub Tenente ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-subtenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-sagento1'] = {
        _config = {
            title = '1º SGT ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-sagento1.permissao',
    },
    ['rocam-sagento1-apaisana'] = {
        _config = {
            title = '1º SGT ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-sagento1-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-sagento2'] = {
        _config = {
            title = '2º SGT ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-sagento2.permissao',
    },
    ['rocam-sagento2-apaisana'] = {
        _config = {
            title = '2º SGT ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-sagento2-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-sagento3'] = {
        _config = {
            title = '3º SGT ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'rocam-sagento3.permissao',
    },
    ['rocam-sagento3-apaisana'] = {
        _config = {
            title = '3º SGT ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-sagento3-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-cabo'] = {
        _config = {
            title = 'Cabo ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-cabo.permissao',
    },
    ['rocam-cabo-apaisana'] = {
        _config = {
            title = 'Cabo ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-cabo-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['rocam-soldado'] = {
        _config = {
            title = 'Soldado ROCAM',
            gtype = 'job'
        },
        'rocam.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'rocam-soldado.permissao',
    },
    ['rocam-soldado-apaisana'] = {
        _config = {
            title = 'Soldado ROCAM apaisana',
            gtype = 'job'
        },
        'rocam-soldado-apaisana.permissao',
        'paisana-policia.permissao',
    },

    -- [ ROCAM - Ronda Ostensiva com Apoio de Motocicletas - FIM ] ------------

    -- [ BAEP - Batalhão de Ações Especiais de Polícia - Inicio ] ------------

    ['baep-coronel'] = {
        _config = {
            title = 'Coronel BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-coronel.permissao',
    },
    ['baep-coronel-apaisana'] = {
        _config = {
            title = 'Coronel BAEP apaisana',
            gtype = 'job'
        },
        'baep-coronel-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['baep-ten-coronel'] = {
        _config = {
            title = 'Tenente Coronel BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-coronel.permissao',
    },
    ['baep-ten-coronel-apaisana'] = {
        _config = {
            title = 'Tenente Coronel BAEP apaisana',
            gtype = 'job'
        },
        'baep-coronel-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-major'] = {
        _config = {
            title = 'Major BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-major.permissao',
    },
    ['baep-major-apaisana'] = {
        _config = {
            title = 'Major BAEP apaisana',
            gtype = 'job'
        },
        'baep-major-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-capitao'] = {
        _config = {
            title = 'Capitao BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-capitao.permissao',
    },
    ['baep-capitao-apaisana'] = {
        _config = {
            title = 'Capitao BAEP apaisana',
            gtype = 'job'
        },
        'baep-capitao-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-1tenet'] = {
        _config = {
            title = '1º Tenente BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-1tenet.permissao',
    },
    ['baep-1tenet-apaisana'] = {
        _config = {
            title = '1º Tenente BAEP apaisana',
            gtype = 'job'
        },
        'baep-1tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-2tenet'] = {
        _config = {
            title = '2º Tenente BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-2tenet.permissao',
    },
    ['baep-2tenet-apaisana'] = {
        _config = {
            title = '2º Tenente BAEP apaisana',
            gtype = 'job'
        },
        'baep-2tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-subtenet'] = {
        _config = {
            title = 'Sub Tenente BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-subtenet.permissao',
    },
    ['baep-subtenet-apaisana'] = {
        _config = {
            title = 'Sub Tenente BAEP apaisana',
            gtype = 'job'
        },
        'baep-subtenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-sagento1'] = {
        _config = {
            title = '1º SGT BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-sagento1.permissao',
    },
    ['baep-sagento1-apaisana'] = {
        _config = {
            title = '1º SGT BAEP apaisana',
            gtype = 'job'
        },
        'baep-sagento1-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-sagento2'] = {
        _config = {
            title = '2º SGT BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-sagento2.permissao',
    },
    ['baep-sagento2-apaisana'] = {
        _config = {
            title = '2º SGT BAEP apaisana',
            gtype = 'job'
        },
        'baep-sagento2-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-sagento3'] = {
        _config = {
            title = '3º SGT BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-sagento3.permissao',
    },
    ['baep-sagento3-apaisana'] = {
        _config = {
            title = '3º SGT BAEP apaisana',
            gtype = 'job'
        },
        'baep-sagento3-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-cabo'] = {
        _config = {
            title = 'Cabo BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-cabo.permissao',
    },
    ['baep-cabo-apaisana'] = {
        _config = {
            title = 'Cabo BAEP apaisana',
            gtype = 'job'
        },
        'baep-cabo-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['baep-soldado'] = {
        _config = {
            title = 'Soldado BAEP',
            gtype = 'job'
        },
        'baep.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'baep-soldado.permissao',
    },
    ['baep-soldado-apaisana'] = {
        _config = {
            title = 'Soldado BAEP apaisana',
            gtype = 'job'
        },
        'baep-soldado-apaisana.permissao',
        'paisana-policia.permissao',
    },

    -- [ BAEP - Batalhão de Ações Especiais de Polícia - FIM ] ------------

    -- [ GRAER - Grupamento Aéreo da Polícia Militar - Inicio ] ------------

    ['graer-coronel'] = {
        _config = {
            title = 'Coronel GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-coronel.permissao',
    },
    ['graer-coronel-apaisana'] = {
        _config = {
            title = 'Coronel GRAER apaisana',
            gtype = 'job'
        },
        'graer-coronel-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-ten-coronel'] = {
        _config = {
            title = 'Tenente Coronel GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-ten-coronel.permissao',
    },
    ['graer-ten-coronel-apaisana'] = {
        _config = {
            title = 'Tenente Coronel GRAER apaisana',
            gtype = 'job'
        },
        'graer-ten-coronel-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-major'] = {
        _config = {
            title = 'Major GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-major.permissao',
    },
    ['graer-major-apaisana'] = {
        _config = {
            title = 'Major GRAER apaisana',
            gtype = 'job'
        },
        'graer-major-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-capitao'] = {
        _config = {
            title = 'Capitao GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-capitao.permissao',
    },
    ['graer-capitao-apaisana'] = {
        _config = {
            title = 'Capitao GRAER apaisana',
            gtype = 'job'
        },
        'graer-capitao-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-1tenet'] = {
        _config = {
            title = '1º Tenente GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-1tenet.permissao',
    },
    ['graer-1tenet-apaisana'] = {
        _config = {
            title = '1º Tenente GRAER apaisana',
            gtype = 'job'
        },
        'graer-1tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-2tenet'] = {
        _config = {
            title = '2º Tenente GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-2tenet.permissao',
    },
    ['graer-2tenet-apaisana'] = {
        _config = {
            title = '2º Tenente GRAER apaisana',
            gtype = 'job'
        },
        'graer-2tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-subtenet'] = {
        _config = {
            title = 'Sub Tenente GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-subtenet.permissao',
    },
    ['graer-subtenet-apaisana'] = {
        _config = {
            title = 'Sub Tenente GRAER apaisana',
            gtype = 'job'
        },
        'graer-subtenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-sagento1'] = {
        _config = {
            title = '1º SGT GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-sagento1.permissao',
    },
    ['graer-sagento1-apaisana'] = {
        _config = {
            title = '1º SGT GRAER apaisana',
            gtype = 'job'
        },
        'graer-sagento1-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-sagento2'] = {
        _config = {
            title = '2º SGT GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-sagento2.permissao',
    },
    ['graer-sagento2-apaisana'] = {
        _config = {
            title = '2º SGT GRAER apaisana',
            gtype = 'job'
        },
        'graer-sagento2-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-sagento3'] = {
        _config = {
            title = '3º SGT GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-sagento3.permissao',
    },
    ['graer-sagento3-apaisana'] = {
        _config = {
            title = '3º SGT GRAER apaisana',
            gtype = 'job'
        },
        'graer-sagento3-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-cabo'] = {
        _config = {
            title = 'Cabo GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-cabo.permissao',
    },
    ['graer-cabo-apaisana'] = {
        _config = {
            title = 'Cabo GRAER apaisana',
            gtype = 'job'
        },
        'graer-cabo-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['graer-soldado'] = {
        _config = {
            title = 'Soldado GRAER',
            gtype = 'job'
        },
        'graer.permissao',
        'cameras.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',

        'graer-soldado.permissao',
    },
    ['graer-soldado-apaisana'] = {
        _config = {
            title = 'Soldado GRAER apaisana',
            gtype = 'job'
        },
        'graer-soldado-apaisana.permissao',
        'paisana-policia.permissao',
    },

    -- [ GRAER - Grupamento Aéreo da Polícia Militar - FIM ] ------------

    -- [ TOR - Tático Ostensivo Rodoviário - Inicio ] ------------

    ['tor-coronel'] = {
        _config = {
            title = 'Coronel TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-coronel.permissao',
        'policia.permissao',
        'cameras.permissao',
        'tor-coronel.permissao'
    },
    ['tor-coronel-apaisana'] = {
        _config = {
            title = 'Coronel TOR apaisana',
            gtype = 'job'
        },
        'tor-coronel-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['tor-ten-coronel'] = {
        _config = {
            title = 'Tenente Coronel TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'policia.permissao',
        'cameras.permissao',
        'tor-ten-coronel.permissao'
    },
    ['tor-ten-coronel-apaisana'] = {
        _config = {
            title = 'Tenente Coronel TOR apaisana',
            gtype = 'job'
        },
        'tor-ten-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-major'] = {
        _config = {
            title = 'Major TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-major.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['tor-major-apaisana'] = {
        _config = {
            title = 'Major TOR apaisana',
            gtype = 'job'
        },
        'tor-major-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-capitao'] = {
        _config = {
            title = 'Capitao TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-capitao.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['tor-capitao-apaisana'] = {
        _config = {
            title = 'Capitao TOR apaisana',
            gtype = 'job'
        },
        'tor-capitao-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-1tenet'] = {
        _config = {
            title = '1º Tenente TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-1tenet.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['tor-1tenet-apaisana'] = {
        _config = {
            title = '1º Tenente TOR apaisana',
            gtype = 'job'
        },
        'tor-1tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-2tenet'] = {
        _config = {
            title = '2º Tenente TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-2tenet.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['tor-2tenet-apaisana'] = {
        _config = {
            title = '2º Tenente TOR apaisana',
            gtype = 'job'
        },
        'tor-2tenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-subtenet'] = {
        _config = {
            title = 'Sub Tenente TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-subtenet.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['tor-subtenet-apaisana'] = {
        _config = {
            title = 'Sub Tenente TOR apaisana',
            gtype = 'job'
        },
        'tor-subtenet-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-sagento1'] = {
        _config = {
            title = '1º SGT TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-sagento1.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['tor-sagento1-apaisana'] = {
        _config = {
            title = '1º SGT TOR apaisana',
            gtype = 'job'
        },
        'tor-sagento1-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-sagento2'] = {
        _config = {
            title = '2º SGT TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-sagento2.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['tor-sagento2-apaisana'] = {
        _config = {
            title = '2º SGT TOR apaisana',
            gtype = 'job'
        },
        'tor-sagento2-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['tor-sagento3'] = {
        _config = {
            title = '3º SGT TOR',
            gtype = 'job'
        },
        'tor.permissao',
        'tor-sagento3.permissao',
        'policia.permissao',
        'cameras.permissao'
    },
    ['tor-sagento3-apaisana'] = {
        _config = {
            title = '3º SGT TOR apaisana',
            gtype = 'job'
        },
        'tor-sagento3-apaisana.permissao',
        'paisana-policia.permissao',
    },

    -- [ TOR - Tático Ostensivo Rodoviário - FIM] ------------

    -- [ PF - Polícia Federal Inicio ] -----------------

    ['diretor-geral-pf'] = {
        _config = {
            title = 'Dir. Geral PF',
            gtype = 'job'
        },
        'diretor-geral-pf.permissao',
        'pf.permissao',
        'delegado-geral-pf.permissao',
        'cot-pf.permissao',
        'policia-rastreador.permissao',
        'policia.permissao',
        'cameras.permissao'
    },
    ['diretor-geral-pf-apaisana'] = {
        _config = {
            title = 'Dir. Geral PF Apaisana',
            gtype = 'job'
        },
        'diretor-geral-pf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['superintendente-pf'] = {
        _config = {
            title = 'Superintendente PF',
            gtype = 'job'
        },
        'superintendente-pf.permissao',
        'pf.permissao',
        'cot-pf.permissao',
        'policia-rastreador.permissao',
        'policia.permissao',
        'cameras.permissao'
    },
    ['superintendente-pf-apaisana'] = {
        _config = {
            title = 'Superintendente PF Apaisana',
            gtype = 'job'
        },
        'superintendente-pf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['delegado-pf'] = {
        _config = {
            title = 'Delegado PF',
            gtype = 'job'
        },
        'delegado-pf.permissao',
        'policia-rastreador.permissao',
        'policia.permissao',
        'cameras.permissao',
        'pf.permissao',
    },
    ['delegado-pf-apaisana'] = {
        _config = {
            title = 'Delegado PF Apaisana',
            gtype = 'job'
        },
        'delegado-pf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['delegado-auxiliar-pf'] = {
        _config = {
            title = 'Delegado Auxiliar Policia Federal',
            gtype = 'job'
        },
        'delegado-auxiliar-pf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'pf.permissao',
    },
    ['delegado-auxiliar-pf-paisana'] = {
        _config = {
            title = 'Delegado Aux PF Apaisana',
            gtype = 'job'
        },
        'delegado-auxiliar-pf-paisana.permissao'
    },

    ['perito-criminal-pf'] = {
        _config = {
            title = 'Perito Criminal Policia Federal',
            gtype = 'job'
        },
        'perito-criminal-pf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'pf.permissao',
    },
    ['perito-criminal-pf-paisana'] = {
        _config = {
            title = 'Perito Criminal PF Apaisana',
            gtype = 'job'
        },
        'perito-criminal-pf-paisana.permissao'
    },

    ['escrivao-pf'] = {
        _config = {
            title = 'Escrivao Policia Federal',
            gtype = 'job'
        },
        'escrivao-pf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'pf.permissao',
    },
    ['escrivao-pf-apaisana'] = {
        _config = {
            title = 'Escrivao PF Apaisana',
            gtype = 'job'
        },
        'escrivao-pf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['comandante-cot'] = {
        _config = {
            title = 'Comandante C.O.T',
            gtype = 'job'
        },
        'cot.permissao',
        'pf.permissao',
        'cot-cmd-pf.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'cameras.permissao',
    },
    ['comandante-cot-apaisana'] = {
        _config = {
            title = 'Comandante C.O.T apaisana',
            gtype = 'job'
        },
        'comandante-cot-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['cot-ag-pf'] = {
        _config = {
            title = 'Agente C.O.T. PF',
            gtype = 'job'
        },
        'cot-ag-pf.permissao',
        'pf.permissao',
        'cot-pf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'cot.permissao',
    },
    ['cot-ag-pf-apaisana'] = {
        _config = {
            title = 'Agente C.O.T apaisana',
            gtype = 'job'
        },
        'cot-ag-pf-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['dip-dir-pf'] = {
        _config = {
            title = 'Dir. de Inteligência PF',
            gtype = 'job'
        },
        'dip-dir-pf.permissao',
        'pf.permissao',
        'cot.permissao',
        'cot-cmd-pf.permissao',
        'policia.permissao',
        'policia-rastreador.permissao',
        'cameras.permissao',
    },
    ['dip-dir-pf-apaisana'] = {
        _config = {
            title = 'DIP PF Apaisana',
            gtype = 'job'
        },
        'dip-dir-pf-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['dip-ag-pf'] = {
        _config = {
            title = 'Agente D.I.P. PF',
            gtype = 'job'
        },
        'dip-ag-pf.permissao',
        'pf.permissao',
        'cot-pf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'cot.permissao'
    },
    ['dip-ag-apaisana'] = {
        _config = {
            title = 'DIP PF Apaisana',
            gtype = 'job'
        },
        'dip-ag-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['agente-pf'] = {
        _config = {
            title = 'Agente Policia Federal',
            gtype = 'job'
        },
        'agente-pf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'pf.permissao',
    },
    ['agente-pf-apaisana'] = {
        _config = {
            title = 'Agente PF Apaisana',
            gtype = 'job'
        },
        'agente-pf-apaisana.permissao',
        'paisana-policia.permissao',
    },

    -- Médico da Policia Federal

    ['medico-pf'] = {
        _config = {
            title = 'Ag. Médico H.F.A.G PF',
            gtype = 'job'
        },
        'medico-pf.permissao',
        'pf.permissao',
        'hospital.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['medico-pf-apaisana'] = {
        _config = {
            title = 'Ag. Médico Apaisana PF',
            gtype = 'job'
        },
        'medico-pf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    -- [ PF - Polícia Federal FIM ] --------------------

    -- [ PRF - Polícia Rodoviaria Federal Inicio ] -----------------

    ['diretor-geral-prf'] = {
        _config = {
            title = 'Dir. Geral PRF',
            gtype = 'job'
        },
        'diretor-geral-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['diretor-geral-prf-apaisana'] = {
        _config = {
            title = 'Dir. Geral Apaisana PRF',
            gtype = 'job'
        },
        'diretor-geral-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['superintendente-prf'] = {
        _config = {
            title = 'Superintendente PRF',
            gtype = 'job'
        },
        'superintendente-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['superintendente-prf-apaisana'] = {
        _config = {
            title = 'Superintendente Apaisana PRF',
            gtype = 'job'
        },
        'superintendente-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['corregedor-prf'] = {
        _config = {
            title = 'Corregedor PRF',
            gtype = 'job'
        },
        'corregedor-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['corregedor-prf-apaisana'] = {
        _config = {
            title = 'Corregedor Apasiana PRF',
            gtype = 'job'
        },
        'corregedor-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['delegado-prf'] = {
        _config = {
            title = 'Delegado PRF',
            gtype = 'job'
        },
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'delegado-prf.permissao'
    },
    ['delegado-prf-apaisana'] = {
        _config = {
            title = 'Delegado Apaisana PRF',
            gtype = 'job'
        },
        'delegado-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['delegado-auxiliar-prf'] = {
        _config = {
            title = 'Delegado Auxiliar PRF',
            gtype = 'job'
        },
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
        'delegado-auxiliar-prf.permissao'
    },
    ['delegado-auxiliar-prf-apaisana'] = {
        _config = {
            title = 'Delegado Aux Apaisana PRF',
            gtype = 'job'
        },
        'delegado-auxiliar-prf-apaisana.permissao',
        'paisana-policia.permissao',
    },

    ['seop-dir-prf'] = {
        _config = {
            title = 'Dir. Operações PRF',
            gtype = 'job'
        },
        'seop-dir-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['seop-dir-prf-apaisana'] = {
        _config = {
            title = 'Dir. Operações Apaisana PRF',
            gtype = 'job'
        },
        'seop-dir-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['seop-ag-prf'] = {
        _config = {
            title = 'Agente SEOP PRF',
            gtype = 'job'
        },
        'seop-ag-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['seop-ag-prf-apaisana'] = {
        _config = {
            title = 'Agente SEOP Apaisana PRF',
            gtype = 'job'
        },
        'seop-ag-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['seint-dir-prf'] = {
        _config = {
            title = 'Dir. Serv. Inteligência PRF',
            gtype = 'job'
        },
        'seint-dir-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['seint-dir-prf-apaisana'] = {
        _config = {
            title = 'Dir. Serv. Inteligência Apasiana PRF',
            gtype = 'job'
        },
        'seint-dir-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['seint-ag-prf'] = {
        _config = {
            title = 'Agente S.E.I.N.T. PRF',
            gtype = 'job'
        },
        'seint-ag-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao',
    },
    ['seint-ag-prf-apaisana'] = {
        _config = {
            title = 'Agente S.E.I.N.T. Apasiana PRF',
            gtype = 'job'
        },
        'seint-ag-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    ['agente-prf'] = {
        _config = {
            title = 'Agente PRF',
            gtype = 'job'
        },
        'agente-prf.permissao',
        'prf.permissao',
        'policia.permissao',
        'cameras.permissao'
    },
    ['agente-prf-apaisana'] = {
        _config = {
            title = 'Agente Apasiana PRF',
            gtype = 'job'
        },
        'agente-prf-apaisana.permissao',
        'paisana-policia.permissao'
    },

    -- [ PRF - Polícia Rodoviaria Federal FIM ] --------------------

    -- Sets Hospital -----------------------------------------

    -- [ Inicio ] Set Hospital Global

    ['hospital'] = {
        _config = {
            title = 'Membro Hospital',
            gtype = 'job'
        },
        'hospital.permissao'
    },

    ['paisana-hospital'] = {
        _config = {
            title = 'Apaisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao'
    },

    -- [ FIM ] Set Hospital Global

    -- [ Hospital Inicio ] -----------------

    ['dir-geral-hp'] = {
        _config = {
            title = 'Diretor(a) HFAG',
            gtype = 'job'
        },
        'dir-geral-hp.permissao',
        'hospital.permissao'
    },
    ['dir-geral-hp-apaisana'] = {
        _config = {
            title = 'Apaisana Hospital',
            gtype = 'job'
        },
        'dir-geral-hp-apaisana.permissao',
        'paisana-hospital.permissao'
    },

    ['vice-dir-geral-hp'] = {
        _config = {
            title = 'Vice Diretor(a) HFAG',
            gtype = 'job'
        },
        'vice-dir-geral-hp.permissao',
        'hospital.permissao'
    },
    ['vice-dir-geral-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'vice-dir-geral-hp-apaisana.permissao',
    },

    ['medico-cirurgiao-hp'] = {
        _config = {
            title = 'Médico(a) Cirurgião HFAG',
            gtype = 'job'
        },
        'medico-cirurgiao-hp.permissao',
        'hospital.permissao'
    },
    ['medico-cirurgiao-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'medico-cirurgiao-hp-apaisana.permissao'
    },

    ['medico-obstetra-hp'] = {
        _config = {
            title = 'Médico(a) Obstetra HFAG',
            gtype = 'job'
        },
        'medico-obstetra-hp.permissao',
        'hospital.permissao'
    },
    ['medico-obstetra-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'medico-obstetra-hp-apaisana.permissao'
    },

    ['medico-psicologo-hp'] = {
        _config = {
            title = 'Médico(a) Psicólogo(a) HFAG',
            gtype = 'job'
        },
        'medico-psicologo-hp.permissao',
        'hospital.permissao'
    },
    ['medico-psicologo-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'medico-psicologo-hp-apaisana.permissao',
    },

    ['medico-oftal-hp'] = {
        _config = {
            title = 'Médico(a) Oftalmologista HFAG',
            gtype = 'job'
        },
        'medico-oftal-hp.permissao',
        'hospital.permissao'
    },
    ['medico-oftal-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'medico-oftal-hp-apaisana.permissao',
    },

    ['medico-fisio-hp'] = {
        _config = {
            title = 'Médico(a) Fisioterapêutico(a) HFAG',
            gtype = 'job'
        },
        'medico-fisio-hp.permissao',
        'hospital.permissao'
    },
    ['medico-fisio-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'medico-fisio-hp-apaisana.permissao',
    },

    ['medico-clinico-hp'] = {
        _config = {
            title = 'Médico(a) Clinico Geral HFAG',
            gtype = 'job'
        },
        'medico-clinico-hp.permissao',
        'hospital.permissao'
    },
    ['medico-clinico-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'medico-clinico-hp-apaisana.permissao'
    },

    ['paramedico-hp'] = {
        _config = {
            title = 'Paramédico(a) HFAG',
            gtype = 'job'
        },
        'paramedico-hp.permissao',
        'hospital.permissao'
    },
    ['paramedico-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'paramedico-hp-apaisana.permissao',
    },

    ['enfermeiro-hp'] = {
        _config = {
            title = 'Enfermeiro(a) HFAG',
            gtype = 'job'
        },
        'enfermeiro-hp.permissao',
        'hospital.permissao'
    },
    ['enfermeiro-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'enfermeiro-hp-apaisana.permissao',
    },

    ['farmaceutico'] = {
        _config = {
            title = 'Farmaceutico(a)',
            gtype = 'job'
        },
        'farmaceutico.permissao',
        'hospital.permissao'
    },
    ['farmaceutico-apaisana'] = {
        _config = {
            title = 'Paisana Farmaceutico(a)',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'farmaceutico-apaisana.permissao',
    },

    ['estagiario-hp'] = {
        _config = {
            title = 'Estágiario(a) HFAG',
            gtype = 'job'
        },
        'estagiario-hp.permissao',
        'hospital.permissao'
    },
    ['estagiario-hp-apaisana'] = {
        _config = {
            title = 'Paisana Hospital',
            gtype = 'job'
        },
        'paisana-hospital.permissao',
        'estagiario-hp-apasiana.permissao',
    },

    -- [ Hospital FIM ] -----------------

    -- [ Empregos Aleatórios Inicio ] ------

    ['lider-corretor'] = {
        _config = {
            title = 'Corretor Chefe',
            gtype = 'job'
        },
        'lider-corretor.permissao'
    },

    ['corretor'] = {
        _config = {
            title = 'Corretor',
            gtype = 'job'
        },
        'corretor.permissao'
    },

    ['visitante'] = {
        _config = {
            title = 'Visitante',
            gtype = 'job'
        },
        'visitante.permissao'
    },

    ['lider-taxista'] = {
        _config = {
            title = 'Líder Taxista',
            gtype = 'job'
        },
        'lider-taxista.permissao'
    },

    ['taxista'] = {
        _config = {
            title = 'Taxista',
            gtype = 'job'
        },
        'taxista.permissao'
    },

    ['paisana-taxista'] = {
        _config = {
            title = 'Taxista de folga',
            gtype = 'job'
        },
        'paisana-taxista.permissao'
    },

    -- [ Empregos Aleatórios FIM ] ------

    -- [ Inicio ] Mecânica Global

    ['mecanico'] = {
        _config = {
            title = 'Mecânico',
            gtype = 'job'
        },
        'mecanico.permissao'
    },
    ['mecanico-paisana'] = {
        _config = {
            title = 'Mecânico Paisana',
            gtype = 'job'
        },
        'mecanico-paisana.permissao'
    },

    -- [ FIM ] Mecânica Global

    -- [ LosSantos ] ------

    ['lider-ls'] = {
        _config = {
            title = 'Líder LS Custom',
            gtype = 'job'
        },
        'lider-mec-ls.permissao',
        'mecanico.permissao',
        'ls.permissao',
    },
    ['lider-ls-apaisana'] = {
        _config = {
            title = 'Mecânico Paisana',
            gtype = 'job'
        },
        'mecanico-paisana.permissao',
        'lider-mec-apaisana.permissao'
    },

    ['gerente-ls'] = {
        _config = {
            title = 'Gerente LS Custom',
            gtype = 'job'
        },
        'gerente-ls.permissao',
        'mecanico.permissao',
        'ls.permissao',
    },
    ['gerente-ls-apaisana'] = {
        _config = {
            title = 'Mecânico Paisana',
            gtype = 'job'
        },
        'gerente-ls-apaisana.permissao',
        'mecanico-paisana.permissao'
    },

    ['mecanico-ls'] = {
        _config = {
            title = 'Mecânico LS Custom',
            gtype = 'job'
        },
        'mec-ls-reparo.permissao',
        'mecanico.permissao',
        'ls.permissao',
    },
    ['mecanico-ls-apaisana'] = {
        _config = {
            title = 'Mecânico Paisana',
            gtype = 'job'
        },
        'mecanico-ls-apaisana.permissao',
        'mecanico-paisana.permissao'
    },

    -- [ Bennys ] ------

    ['lider-bennys'] = {
        _config = {
            title = 'Líder Bennys',
            gtype = 'job'
        },
        'lider-bennys.permissao',
        'bennys.permissao',
        'mecanico.permissao'
    },
    ['lider-bennys-apaisana'] = {
        _config = {
            title = 'Mecânico Paisana',
            gtype = 'job'
        },
        'lider-bennys-apaisana.permissao',
        'mecanico-paisana.permissao'
    },

    ['gerente-bennys'] = {
        _config = {
            title = 'Gerente Bennys',
            gtype = 'job'
        },
        'gerente-bennys.permissao',
        'bennys.permissao',
        'mecanico.permissao'
    },
    ['gerente-bennys-apaisana'] = {
        _config = {
            title = 'Mecânico Paisana',
            gtype = 'job'
        },
        'gerente-bennys-apaisana.permissao',
        'mecanico-paisana.permissao'
    },

    ['mecanico-bennys'] = {
        _config = {
            title = 'Mecânico Bennys',
            gtype = 'job'
        },
        'mecanico-bennys.permissao',
        'bennys.permissao',
        'mecanico.permissao'
    },
    ['mecanico-bennys-apaisana'] = {
        _config = {
            title = 'Mecânico Paisana',
            gtype = 'job'
        },
        'mecanico-bennys-apaisana.permissao',
        'mecanico-paisana.permissao'
    },

    -- [ ORGS Inicio ] ------------------------------------------

    -- [ Máfia ] ------

    ['mafia'] = {
        _config = {
            title = 'Membro Mafia',
            gtype = 'job'
        },
        'mafia.permissao',
        'prod-armas.permissao',
    },

    ['sub-lider-mafia'] = {
        _config = {
            title = 'Sub Líder Mafia',
            gtype = 'job'
        },
        'sub-lider-mafia.permissao',
        'lider-mafia.permissao',
        'prod-armas.permissao',
        'bau-mafia.permissao',
        'mafia.permissao',
    },

    ['lider-mafia'] = {
        _config = {
            title = 'Líder Mafia',
            gtype = 'job'
        },
        'lider-mafia.permissao',
        'prod-armas.permissao',
        'bau-mafia.permissao',
        'mafia.permissao',
    },

    ------------------------------------

    -- [ Cartel ] ------

    ['cartel'] = {
        _config = {
            title = 'Membro Cartel',
            gtype = 'job'
        },
        'cartel.permissao',
        'prod-armas.permissao',
    },

    ['sub-lider-cartel'] = {
        _config = {
            title = 'Sub Líder Cartel',
            gtype = 'job'
        },
        'sub-lider-cartel.permissao',
        'lider-cartel.permissao',
        'bau-cartel.permissao',
        'prod-armas.permissao',
        'cartel.permissao',
    },

    ['lider-cartel'] = {
        _config = {
            title = 'Líder Cartel',
            gtype = 'job'
        },
        'lider-cartel.permissao',
        'prod-armas.permissao',
        'bau-cartel.permissao',
        'cartel.permissao',
    },

    ------------------------------------

    -- [ Abutres  ] ------

    ['abutres'] = {
        _config = {
            title = 'Membro Abutres',
            gtype = 'job'
        },
        'abutres.permissao',
        'prod-ammo.permissao',
    },

    ['sub-lider-abutres'] = {
        _config = {
            title = 'Sub Líder Abutres',
            gtype = 'job'
        },
        'sub-lider-abutres.permissao',
        'lider-abutres.permissao',
        'bau-abutres.permissao',
        'prod-ammo.permissao',
        'abutres.permissao',
    },

    ['lider-abutres'] = {
        _config = {
            title = 'Líder Abutres',
            gtype = 'job'
        },
        'lider-abutres.permissao',
        'bau-abutres.permissao',
        'prod-ammo.permissao',
        'abutres.permissao',
    },

    ------------------------------------

    -- [ YellowJack ] ------

    ['yellowjack'] = {
        _config = {
            title = 'Membro YellowJack',
            gtype = 'job'
        },
        'yellowjack.permissao',
        'prod-ammo.permissao',
    },

    ['sub-lider-yellowjack'] = {
        _config = {
            title = 'Sub Líder YellowJack',
            gtype = 'job'
        },
        'sub-lider-yellowjack.permissao',
        'lider-yellowjack.permissao',
        'prod-ammo.permissao',
        'bau-yellowjack.permissao',
        'yellowjack.permissao',
    },

    ['lider-yellowjack'] = {
        _config = {
            title = 'Líder YellowJack',
            gtype = 'job'
        },
        'lider-yellowjack.permissao',
        'bau-yellowjack.permissao',
        'yellowjack.permissao',
        'prod-ammo.permissao',
    },

    -- [ Arcade ] ------

    ['arcade'] = {
        _config = {
            title = 'Membro Arcade',
            gtype = 'job'
        },
        'arcade.permissao',
        'prod-meta.permissao',
    },

    ['sub-lider-arcade'] = {
        _config = {
            title = 'Sub Líder Arcade',
            gtype = 'job'
        },
        'sub-lider-arcade.permissao',
        'lider-arcade.permissao',
        'prod-meta.permissao',
        'bau-arcade.permissao',
        'arcade.permissao',
    },

    ['lider-arcade'] = {
        _config = {
            title = 'Líder Arcade',
            gtype = 'job'
        },
        'lider-arcade.permissao',
        'bau-arcade.permissao',
        'prod-meta.permissao',
        'arcade.permissao',
    },

    ------------------------------------

    -- [ Vanilla ] ------

    ['vanilla'] = {
        _config = {
            title = 'Membro Vanilla',
            gtype = 'job'
        },
        'vanilla.permissao',
        'prod-coca.permissao',
    },

    ['sub-lider-vanilla'] = {
        _config = {
            title = 'Sub Líder Vanilla',
            gtype = 'job'
        },
        'sub-lider-vanilla.permissao',
        'lider-vanilla.permissao',
        'bau-vanilla.permissao',
        'prod-coca.permissao',
        'vanilla.permissao',
    },

    ['lider-vanilla'] = {
        _config = {
            title = 'Líder Vanilla',
            gtype = 'job'
        },
        'lider-vanilla.permissao',
        'bau-vanilla.permissao',
        'prod-coca.permissao',
        'vanilla.permissao',
    },

    ------------------------------------

    -- [ Galaxy ] ------

    ['galaxy'] = {
        _config = {
            title = 'Membro Galaxy',
            gtype = 'job'
        },
        'galaxy.permissao',
        'prod-maconha.permissao',
    },

    ['sub-lider-galaxy'] = {
        _config = {
            title = 'Sub Líder Galaxy',
            gtype = 'job'
        },
        'sub-lider-galaxy.permissao',
        'lider-galaxy.permissao',
        'prod-maconha.permissao',
        'bau-galaxy.permissao',
        'galaxy.permissao',
    },

    ['lider-galaxy'] = {
        _config = {
            title = 'Líder Galaxy',
            gtype = 'job'
        },
        'lider-galaxy.permissao',
        'bau-galaxy.permissao',
        'prod-maconha.permissao',
        'galaxy.permissao',
    },

    ------------------------------------

    -- [ Bahamas ] ------

    ['bahamas'] = {
        _config = {
            title = 'Membro Bahamas',
            gtype = 'job'
        },
        'bahamas.permissao',
        'prod-lsd.permissao'
    },

    ['sub-lider-bahamas'] = {
        _config = {
            title = 'Sub Líder Bahamas',
            gtype = 'job'
        },
        'sub-lider-bahamas.permissao',
        'lider-bahamas.permissao',
        'bau-bahamas.permissao',
        'prod-lsd.permissao',
        'bahamas.permissao',
    },

    ['lider-bahamas'] = {
        _config = {
            title = 'Líder Bahamas',
            gtype = 'job'
        },
        'lider-bahamas.permissao',
        'bau-bahamas.permissao',
        'prod-lsd.permissao',
        'bahamas.permissao',
    },

    ------------------------------------

    -- [ Tequilla ] ------

    ['tequilla'] = {
        _config = {
            title = 'Membro Tequilla',
            gtype = 'job'
        },
        'tequilla.permissao',
        'lavagem-dinheiro.permissao',
    },

    ['sub-lider-tequilla'] = {
        _config = {
            title = 'Sub Líder Tequilla',
            gtype = 'job'
        },
        'sub-lider-tequilla.permissao',
        'lider-tequilla.permissao',
        'bau-tequilla.permissao',
        'lavagem-dinheiro.permissao',
        'tequilla.permissao',
    },

    ['lider-tequilla'] = {
        _config = {
            title = 'Líder Tequilla',
            gtype = 'job'
        },
        'lider-tequilla.permissao',
        'bau-tequilla.permissao',
        'lavagem-dinheiro.permissao',
        'tequilla.permissao',
    },

    ------------------------------------

    -- [ Triad ] ------

    ['triad'] = {
        _config = {
            title = 'Membro Triad',
            gtype = 'job'
        },
        'triad.permissao',
        'prod-items.permissao'
    },

    ['sub-lider-triad'] = {
        _config = {
            title = 'Sub Líder Triad',
            gtype = 'job'
        },
        'sub-lider-triad.permissao',
        'lider-triad.permissao',
        'bau-triad.permissao',
        'prod-items.permissao',
        'triad.permissao',
    },

    ['lider-triad'] = {
        _config = {
            title = 'Líder Triad',
            gtype = 'job'
        },
        'lider-triad.permissao',
        'bau-triad.permissao',
        'prod-items.permissao',
        'triad.permissao',
    },

    ------------------------------------

    -- [ Insanos ] ------

    ['insanos'] = {
        _config = {
            title = 'Membro Insanos',
            gtype = 'job'
        },
        'insanos.permissao',
        'lavagem-dinheiro.permissao'
    },

    ['sub-lider-insanos'] = {
        _config = {
            title = 'Sub Líder Insanos',
            gtype = 'job'
        },
        'sub-lider-insanos.permissao',
        'lider-insanos.permissao',
        'lavagem-dinheiro.permissao',
        'bau-insanos.permissao',
        'insanos.permissao',
    },

    ['lider-insanos'] = {
        _config = {
            title = 'Líder Insanos',
            gtype = 'job'
        },
        'lider-insanos.permissao',
        'bau-insanos.permissao',
        'lavagem-dinheiro.permissao',
        'insanos.permissao',
    },

    ------------------------------------

    -- [ PCC ] ------

    ['pcc'] = {
        _config = {
            title = 'Membro PCC',
            gtype = 'job'
        },
        'pcc.permissao',
        'prod-coca.permissao',
    },

    ['sub-lider-pcc'] = {
        _config = {
            title = 'Sub Líder PCC',
            gtype = 'job'
        },
        'sub-lider-pcc.permissao',
        'lider-pcc.permissao',
        'prod-coca.permissao',
        'bau-pcc.permissao',
        'pcc.permissao',
    },

    ['lider-pcc'] = {
        _config = {
            title = 'Líder PCC',
            gtype = 'job'
        },
        'lider-pcc.permissao',
        'bau-pcc.permissao',
        'prod-coca.permissao',
        'pcc.permissao',
    },

    ------------------------------------

    -- [ CV ] ------

    ['cv'] = {
        _config = {
            title = 'Membro CV',
            gtype = 'job'
        },
        'cv.permissao'
    },

    ['sub-lider-cv'] = {
        _config = {
            title = 'Sub Líder CV',
            gtype = 'job'
        },
        'sub-lider-cv.permissao',
        'lider-cv.permissao',
        'bau-cv.permissao',
        'cv.permissao',
    },

    ['lider-cv'] = {
        _config = {
            title = 'Líder CV',
            gtype = 'job'
        },
        'lider-cv.permissao',
        'bau-cv.permissao',
        'cv.permissao'
    },

    -- [ ORGS ] Fim -----------------------

    -- [ STAFF ] Inicio -----------------------

    ['manager'] = {
        _config = {
            title = 'Manager',
            gtype = 'staff'
        },
        'player.som',
        'player.blips',
        'player.noclip',
        'player.teleport',
        'player.secret',
        'player.spec',
        'tabstaff.permissao',
        'tabstaff.ban',
        'tabstaff.item',
        'tabstaff.anunciogeral',
        'tabstaff.adv',
        'tabstaff.kick',
        'tabstaff.addcar',
        'tabstaff.renomear',
        'tabstaff.emprego',
        'tabstaff.registro',
        'tabstaff.celular',
        'tabstaff.carteira',
        'tabstaff.banco',
        'staff.permissao',
        'porte.permissao',
        'spec.permissao', -- acesso ao /spec id (tela outros jogadores)
        'player.wall', -- acesso ao /wall (ver todos jogadores, id, vida, colete etc.)
        'mqcu.permissao', -- acesso ao /mqcu (deletar props/npcs/veiculos)
        'request.screenshot',
        'manager.permissao'
    },

    ['off-manager'] = {
        _config = {
            title = 'Manager',
            gtype = 'staff'
        },
        'player.blips',
        'player.noclip',
        'player.teleport',
        'player.secret',
        'player.spec',
        'off-manager.permissao'
    },

    ['administrador'] = {
        _config = {
            title = 'Administrador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        'tabstaff.permissao',
        'tabstaff.ban',
        'tabstaff.item',
        'tabstaff.anunciogeral',
        'tabstaff.adv',
        'tabstaff.kick',
        'tabstaff.addcar',
        'tabstaff.renomear',
        'tabstaff.emprego',
        'tabstaff.registro',
        'tabstaff.celular',
        'tabstaff.carteira',
        'tabstaff.banco',
        'staff.permissao',
        "spec.permissao", -- acesso ao /spec id (tela outros jogadores)
        "player.wall", -- acesso ao /wall (ver todos jogadores, id, vida, colete etc.)
        "mqcu.permissao", -- acesso ao /mqcu (deletar props/npcs/veiculos)
        'administrador.permissao'
    },

    ['off-administrador'] = {
        _config = {
            title = 'Administrador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        'off-administrador.permissao'
    },

    ['moderador'] = {
        _config = {
            title = 'Moderador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        'tabstaff.permissao',
        'tabstaff.ban',
        'tabstaff.adv',
        'tabstaff.kick',
        'staff.permissao',
        "spec.permissao", -- acesso ao /spec id (tela outros jogadores)
        "player.wall", -- acesso ao /wall (ver todos jogadores, id, vida, colete etc.)
        "mqcu.permissao", -- acesso ao /mqcu (deletar props/npcs/veiculos)
        'moderador.permissao'
    },

    ['off-moderador'] = {
        _config = {
            title = 'Moderador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        'off-moderador.permissao'
    },

    ['suporte'] = {
        _config = {
            title = 'Suporte',
            gtype = 'staff'
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        'tabstaff.permissao',
        'tabstaff.ban',
        'tabstaff.adv',
        'tabstaff.kick',
        'staff.permissao',
        "spec.permissao", -- acesso ao /spec id (tela outros jogadores)
        "player.wall", -- acesso ao /wall (ver todos jogadores, id, vida, colete etc.)
        "mqcu.permissao", -- acesso ao /mqcu (deletar props/npcs/veiculos)
        'suporte.permissao'
    },
    ['off-suporte'] = {
        _config = {
            title = 'Suporte',
            gtype = 'staff'
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        'off-suporte.permissao'
    },

    -- [ STAFF ] FIM -----------------------

    -- [ VIP ] Inicio -----------------------

    ['ultimate'] = {
        _config = {
            title = 'Ultimate',
            gtype = 'vip'
        },
        'ultimate.permissao',
        'weaponattachs.permissao',
        'neoncontrol.permissao',
        'jbl.permissao',
        'player.som',
    },

    ['platinum'] = {
        _config = {
            title = 'Platinum',
            gtype = 'vip'
        },
        'platinum.permissao',
        'weaponattachs.permissao',
        'neoncontrol.permissao',
        'jbl.permissao',
        'player.som'
    },

    ['platina'] = {
        _config = {
            title = 'Platina',
            gtype = 'vip'
        },
        'platina.permissao',
        'weaponattachs.permissao',
        'neoncontrol.permissao',
        'jbl.permissao',
        'player.som'
    },

    ['ouro'] = {
        _config = {
            title = 'Ouro',
            gtype = 'vip'
        },
        'ouro.permissao',
        'weaponattachs.permissao',
        'jbl.permissao',
        'player.som'
    },

    ['prata'] = {
        _config = {
            title = 'Prata',
            gtype = 'vip'
        },
        'prata.permissao',
        'jbl.permissao',
        'weaponattachs.permissao'
    },

    ['bronze'] = {
        _config = {
            title = 'Bronze',
            gtype = 'vip'
        },
        'bronze.permissao',
        'jbl.permissao'
    },

    ['boasvindas'] = {
        _config = {
            title = 'boasvindas',
            gtype = 'vip'
        },
        'boasvindas.permissao',
        'jbl.permissao'
    }

    -- [ VIP ] FIM -----------------------
}
