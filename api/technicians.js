const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = process.env.SUPABASE_URL || 'https://cyoimmsnsndqtouezgpg.supabase.co';
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY || 'sb_publishable_4Xhddi-Dvw0SYz7neqbgiQ_ZjbAEajg';

let supabase = null;
try {
  if (SUPABASE_URL && SUPABASE_KEY) {
    supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
  }
} catch (e) {
  console.error('[API technicians] Erro ao instanciar Supabase:', e.message);
}

module.exports = async (req, res) => {
  // Configuração CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  // 1. GET: Retorna lista de técnicos ordenados por avaliação
  if (req.method === 'GET') {
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('technicians')
          .select('*')
          .order('avaliacao', { ascending: false });

        if (!error && data) {
          return res.status(200).json(data);
        }
      } catch (err) {
        console.error('Erro ao buscar técnicos:', err.message);
      }
    }
    return res.status(200).json([]);
  }

  // 2. POST: Cadastra ou atualiza técnico
  if (req.method === 'POST') {
    let body = req.body;
    if (typeof body === 'string') {
      try {
        body = JSON.parse(body);
      } catch (e) {
        body = {};
      }
    }
    body = body || {};

    const payload = {
      nome: body.nome,
      especialidade: body.especialidade,
      descricao: body.descricao || '',
      categorias: body.categorias || [],
      cep: body.cep || '',
      bairro: body.bairro || 'Manaus',
      cidade: 'Manaus',
      estado: 'AM',
      whatsapp: body.whatsapp,
      foto: body.foto || 'https://lh3.googleusercontent.com/aida-public/AB6AXuCrD9Q71351UvQUcfyiYUt7RNYQ4sdeNkX2ecTKdjK7K2tQtem0yx_zMAwazOunHpBZ8WIL2fqpXYI9uFD1P8zkilTkgZSgXDB5Bs5H7h-rIn8E7oi7HIsLFl3Ple7Cqt4DWXSWHC3ETcvWLU5Gmf7UNWApTJlfxhuQNVrrDDZpkpcosvM2CS6OPfVdKJBDZm7XKFUlnnZelr24uXWJJKfyMjoVsTYb8LkoHZzlr2Q',
      avaliacao: parseFloat(body.avaliacao) || 5.0,
      atendimentos: parseInt(body.atendimentos) || 1,
      urgente: !!body.urgente,
      verificado: body.verificado !== false
    };

    if (supabase) {
      try {
        if (body.id && !isNaN(Number(body.id))) {
          // Atualização de técnico existente
          const { data, error } = await supabase
            .from('technicians')
            .update(payload)
            .eq('id', Number(body.id))
            .select();

          if (error) {
            return res.status(500).json({ error: error.message });
          }
          return res.status(200).json({ success: true, technician: data ? data[0] : payload });
        } else {
          // Criação de novo técnico
          const { data, error } = await supabase
            .from('technicians')
            .insert(payload)
            .select();

          if (error) {
            return res.status(500).json({ error: error.message });
          }
          return res.status(201).json({ success: true, technician: data ? data[0] : payload });
        }
      } catch (err) {
        return res.status(500).json({ error: err.message });
      }
    }
    return res.status(500).json({ error: 'Supabase não inicializado' });
  }

  // 3. DELETE: Remove técnico por ID
  if (req.method === 'DELETE') {
    const id = req.query.id || (req.body && req.body.id);
    if (!id) {
      return res.status(400).json({ error: 'ID do técnico é obrigatório' });
    }

    if (supabase) {
      try {
        const { error } = await supabase
          .from('technicians')
          .delete()
          .eq('id', Number(id));

        if (error) {
          return res.status(500).json({ error: error.message });
        }
        return res.status(200).json({ success: true, id });
      } catch (err) {
        return res.status(500).json({ error: err.message });
      }
    }
    return res.status(500).json({ error: 'Supabase não inicializado' });
  }

  return res.status(405).json({ error: 'Método não permitido' });
};

