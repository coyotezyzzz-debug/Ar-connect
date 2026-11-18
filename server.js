const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const PORT = process.env.PORT || 3000;
const BASE_DIR = __dirname;
const DATA_FILE = path.join(BASE_DIR, 'data', 'technicians.json');
const REVIEWS_FILE = path.join(BASE_DIR, 'data', 'reviews.json');

const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.svg': 'image/svg+xml',
  '.gif': 'image/gif',
  '.webp': 'image/webp',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf'
};

function getTechnicians() {
  try {
    if (fs.existsSync(DATA_FILE)) {
      const content = fs.readFileSync(DATA_FILE, 'utf-8');
      return JSON.parse(content);
    }
  } catch (e) {
    console.error('Erro ao ler data/technicians.json:', e);
  }
  return [];
}

function saveTechnicians(list) {
  try {
    const dir = path.dirname(DATA_FILE);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(DATA_FILE, JSON.stringify(list, null, 2), 'utf-8');
    return true;
  } catch (e) {
    console.error('Erro ao salvar data/technicians.json:', e);
    return false;
  }
}

function getReviews() {
  try {
    if (fs.existsSync(REVIEWS_FILE)) {
      const content = fs.readFileSync(REVIEWS_FILE, 'utf-8');
      return JSON.parse(content);
    }
  } catch (e) {
    console.error('Erro ao ler data/reviews.json:', e);
  }
  return [];
}

function saveReviews(list) {
  try {
    const dir = path.dirname(REVIEWS_FILE);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(REVIEWS_FILE, JSON.stringify(list, null, 2), 'utf-8');
    return true;
  } catch (e) {
    console.error('Erro ao salvar data/reviews.json:', e);
    return false;
  }
}

const server = http.createServer((req, res) => {
  const parsedUrl = new URL(req.url, `http://${req.headers.host || 'localhost'}`);
  let pathname = decodeURIComponent(parsedUrl.pathname);

  // API TECHNICIANS
  if (pathname === '/api/technicians') {
    if (req.method === 'GET') {
      const list = getTechnicians();
      res.writeHead(200, {
        'Content-Type': 'application/json; charset=utf-8',
        'Cache-Control': 'no-cache'
      });
      return res.end(JSON.stringify(list));
    }

    if (req.method === 'POST') {
      let body = '';
      req.on('data', chunk => { body += chunk; });
      req.on('end', () => {
        try {
          const tech = JSON.parse(body);
          const list = getTechnicians();
          
          if (tech.id) {
            // Edit existing
            const index = list.findIndex(t => String(t.id) === String(tech.id));
            if (index !== -1) {
              list[index] = { ...list[index], ...tech };
            } else {
              list.push(tech);
            }
          } else {
            // Add new
            tech.id = Date.now().toString();
            tech.avaliacao = tech.avaliacao || "5.0";
            tech.atendimentos = tech.atendimentos || 1;
            tech.verificado = (tech.verificado !== undefined) ? tech.verificado : true;
            list.unshift(tech);
          }

          saveTechnicians(list);
          res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
          return res.end(JSON.stringify({ success: true, technician: tech }));
        } catch (err) {
          res.writeHead(400, { 'Content-Type': 'application/json; charset=utf-8' });
          return res.end(JSON.stringify({ error: 'JSON inválido' }));
        }
      });
      return;
    }

    if (req.method === 'DELETE') {
      const id = parsedUrl.searchParams.get('id');
      if (!id) {
        res.writeHead(400, { 'Content-Type': 'application/json; charset=utf-8' });
        return res.end(JSON.stringify({ error: 'ID não fornecido' }));
      }

      let list = getTechnicians();
      list = list.filter(t => String(t.id) !== String(id));
      saveTechnicians(list);

      res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
      return res.end(JSON.stringify({ success: true }));
    }
  }

  // API REVIEWS (Only clients leave reviews)
  if (pathname === '/api/reviews') {
    if (req.method === 'GET') {
      const techId = parsedUrl.searchParams.get('techId');
      const techName = parsedUrl.searchParams.get('techName');
      let reviews = getReviews();

      if (techId) {
        reviews = reviews.filter(r => String(r.techId) === String(techId));
      } else if (techName) {
        reviews = reviews.filter(r => r.techName && r.techName.toLowerCase() === techName.toLowerCase());
      }

      res.writeHead(200, {
        'Content-Type': 'application/json; charset=utf-8',
        'Cache-Control': 'no-cache'
      });
      return res.end(JSON.stringify(reviews));
    }

    if (req.method === 'POST') {
      let body = '';
      req.on('data', chunk => { body += chunk; });
      req.on('end', () => {
        try {
          const review = JSON.parse(body);
          if (!review.clientName || !review.rating) {
            res.writeHead(400, { 'Content-Type': 'application/json; charset=utf-8' });
            return res.end(JSON.stringify({ error: 'Nome do cliente e nota são obrigatórios' }));
          }

          review.id = Date.now().toString();
          review.data = new Date().toLocaleDateString('pt-BR');
          review.rating = Number(review.rating) || 5;

          const reviews = getReviews();
          reviews.unshift(review);
          saveReviews(reviews);

          // Update technician reviews and attendance count if found
          const techs = getTechnicians();
          const techIndex = techs.findIndex(t => 
            (review.techId && String(t.id) === String(review.techId)) ||
            (review.techName && t.nome.toLowerCase() === review.techName.toLowerCase())
          );

          if (techIndex !== -1) {
            techs[techIndex].atendimentos = (Number(techs[techIndex].atendimentos) || 0) + 1;
            // update score smoothly
            const currentScore = parseFloat(techs[techIndex].avaliacao) || 5.0;
            const newScore = ((currentScore * 4 + review.rating) / 5).toFixed(2);
            techs[techIndex].avaliacao = newScore;
            saveTechnicians(techs);
          }

          res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
          return res.end(JSON.stringify({ success: true, review }));
        } catch (err) {
          res.writeHead(400, { 'Content-Type': 'application/json; charset=utf-8' });
          return res.end(JSON.stringify({ error: 'JSON inválido' }));
        }
      });
      return;
    }
  }

  // Friendly page routing
  if (pathname === '/' || pathname === '') {
    pathname = '/index.html';
  } else if (pathname === '/encontrar-tecnicos' || pathname === '/encontrar-tecnicos/') {
    pathname = '/encontrar-tecnicos.html';
  } else if (pathname === '/admin' || pathname === '/admin/') {
    pathname = '/admin.html';
  }

  // Safe path validation
  const safePath = path.normalize(path.join(BASE_DIR, pathname));
  if (!safePath.startsWith(BASE_DIR)) {
    res.writeHead(403, { 'Content-Type': 'text/plain; charset=utf-8' });
    return res.end('Acesso negado');
  }

  fs.stat(safePath, (err, stats) => {
    if (err || !stats.isFile()) {
      res.writeHead(404, { 'Content-Type': 'text/html; charset=utf-8' });
      return res.end(`
        <!DOCTYPE html>
        <html lang="pt-BR">
        <head>
          <meta charset="utf-8">
          <title>404 - Página não encontrada</title>
          <style>
            body { font-family: sans-serif; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 90vh; color: #0b1c30; background: #f8f9ff; }
            a { color: #006194; text-decoration: none; font-weight: bold; margin-top: 1rem; }
          </style>
        </head>
        <body>
          <h1>404 - Página não encontrada</h1>
          <a href="/">Voltar para a Página Inicial</a>
        </body>
        </html>
      `);
    }

    const ext = path.extname(safePath).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    fs.readFile(safePath, (readErr, data) => {
      if (readErr) {
        res.writeHead(500, { 'Content-Type': 'text/plain; charset=utf-8' });
        return res.end('Erro interno do servidor');
      }

      const headers = {
        'Content-Type': contentType,
        'Cache-Control': 'no-cache, no-store, must-revalidate'
      };
      if (ext === '.html') {
        headers['Content-Language'] = 'pt-BR';
      }

      res.writeHead(200, headers);
      res.end(data);
    });
  });
});

server.listen(PORT, () => {
  console.log(`\n==================================================`);
  console.log(`🚀 ArConnect Marketplace rodando localmente!`);
  console.log(`📡 URL Principal:        http://localhost:${PORT}`);
  console.log(`🔍 Encontrar Técnicos:   http://localhost:${PORT}/encontrar-tecnicos`);
  console.log(`⚙️ Painel Admin:        http://localhost:${PORT}/admin`);
  console.log(`==================================================\n`);
});
