const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = process.env.SUPABASE_URL || 'https://cyoimmsnsndqtouezgpg.supabase.co';
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY || 'sb_publishable_4Xhddi-Dvw0SYz7neqbgiQ_ZjbAEajg';

let supabase = null;
try {
  if (SUPABASE_URL && SUPABASE_KEY) {
    supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
  }
} catch (e) {
  console.error('[API reviews] Erro ao instanciar Supabase:', e.message);
}

module.exports = async (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  // 1. GET: Retorna todas as avaliações
  if (req.method === 'GET') {
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('reviews')
          .select('*')
          .order('created_at', { ascending: false });

        if (!error && data) {
          const formatted = data.map(r => ({
            id: r.id,
            techId: r.technician_id,
            techName: r.technician_name,
            clientName: r.client_name,
            clientContact: r.client_contact,
            bairro: r.bairro,
            service: r.service,
            rating: r.rating,
            comment: r.comment,
            verificado: r.verificado,
            data: new Date(r.created_at).toLocaleDateString('pt-BR')
          }));
          return res.status(200).json(formatted);
        }
      } catch (err) {
        console.error('Erro ao buscar avaliações:', err.message);
      }
    }
    return res.status(200).json([]);
  }

  // 2. POST: Nova avaliação
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

    const reviewData = {
      technician_id: body.techId ? Number(body.techId) : null,
      technician_name: body.techName || 'Técnico Especialista',
      client_name: body.clientName || 'Cliente ArConnect',
      client_contact: body.clientContact || '',
      bairro: body.bairro || 'Manaus',
      service: body.service || 'Serviço de Climatização',
      rating: parseInt(body.rating) || 5,
      comment: body.comment || '',
      verificado: true
    };

    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('reviews')
          .insert(reviewData)
          .select();

        if (error) {
          return res.status(500).json({ error: error.message });
        }
        return res.status(201).json({ success: true, review: data ? data[0] : reviewData });
      } catch (err) {
        return res.status(500).json({ error: err.message });
      }
    }
    return res.status(500).json({ error: 'Supabase não inicializado' });
  }

  return res.status(405).json({ error: 'Método não permitido' });
};

