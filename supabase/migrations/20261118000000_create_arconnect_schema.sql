-- Migration: ArConnect Schema & Initial Manaus Technicians Data
-- Project: ArConnect (Manaus, AM)
-- Auto-deployed via Supabase GitHub Integration

-- 1. Tabela de Técnicos Homologados
create table if not exists public.technicians (
  id bigint generated always as identity primary key,
  nome text not null,
  especialidade text not null,
  descricao text,
  categorias text[] not null default '{}',
  cep varchar(9),
  bairro text not null,
  cidade text not null default 'Manaus',
  estado varchar(2) not null default 'AM',
  whatsapp text not null,
  foto text,
  avaliacao numeric(3,2) not null default 5.00,
  atendimentos integer not null default 0,
  urgente boolean not null default false,
  verificado boolean not null default true,
  created_at timestamptz not null default now()
);

-- Índices para buscas rápidas
create index if not exists idx_technicians_categorias on public.technicians using gin (categorias);
create index if not exists idx_technicians_urgente on public.technicians (urgente);
create index if not exists idx_technicians_bairro on public.technicians (bairro);

-- RLS: Técnicos
alter table public.technicians enable row level security;

create policy "Permitir leitura pública de técnicos"
  on public.technicians
  for select
  to anon, authenticated
  using (true);

create policy "Permitir gerenciamento completo de técnicos via service_role"
  on public.technicians
  for all
  to service_role
  using (true)
  with check (true);

-- 2. Tabela de Avaliações (Reviews)
create table if not exists public.reviews (
  id bigint generated always as identity primary key,
  technician_id bigint references public.technicians(id) on delete cascade,
  technician_name text not null,
  client_name text not null,
  client_contact text,
  bairro text,
  service text,
  rating smallint not null check (rating >= 1 and rating <= 5),
  comment text not null,
  verificado boolean not null default true,
  created_at timestamptz not null default now()
);

-- Índice para carregamento de avaliações por técnico
create index if not exists idx_reviews_technician_id on public.reviews (technician_id);

-- RLS: Avaliações
alter table public.reviews enable row level security;

create policy "Permitir leitura pública de avaliações"
  on public.reviews
  for select
  to anon, authenticated
  using (true);

create policy "Permitir envio de avaliações por clientes"
  on public.reviews
  for insert
  to anon, authenticated
  with check (rating >= 1 and rating <= 5);

-- 3. Tabela de Agendamentos (Bookings / Leads)
create table if not exists public.bookings (
  id bigint generated always as identity primary key,
  technician_id bigint references public.technicians(id) on delete set null,
  service text not null,
  brand text,
  capacity text,
  preferred_date date,
  cep varchar(9),
  bairro text not null,
  status text not null default 'whatsapp_iniciado',
  created_at timestamptz not null default now()
);

create index if not exists idx_bookings_technician_id on public.bookings (technician_id);

-- RLS: Agendamentos
alter table public.bookings enable row level security;

create policy "Permitir registro de agendamentos pelo cliente"
  on public.bookings
  for insert
  to anon, authenticated
  with check (true);

create policy "Permitir gerenciamento de agendamentos via service_role"
  on public.bookings
  for all
  to service_role
  using (true)
  with check (true);

-- 4. Tabela de Clientes Registrados
create table if not exists public.clients (
  id bigint generated always as identity primary key,
  name text not null,
  contact text,
  cep varchar(9),
  bairro text,
  created_at timestamptz not null default now()
);

alter table public.clients enable row level security;

create policy "Permitir cadastro de perfil de cliente"
  on public.clients
  for insert
  to anon, authenticated
  with check (true);

create policy "Permitir leitura pública de perfis de clientes"
  on public.clients
  for select
  to anon, authenticated
  using (true);

-- 5. Seed inicial com os Técnicos Homologados de Manaus
insert into public.technicians (nome, especialidade, descricao, categorias, cep, bairro, whatsapp, foto, avaliacao, atendimentos, urgente, verificado)
values
  (
    'Matheus Silva',
    'Instalação Split & Inverter',
    'Atendimento técnico residencial e comercial com teste de estanqueidade e vácuo.',
    array['instalacao', 'manutencao'],
    '69057-000',
    'Adrianópolis',
    '(92) 99821-4402',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCrD9Q71351UvQUcfyiYUt7RNYQ4sdeNkX2ecTKdjK7K2tQtem0yx_zMAwazOunHpBZ8WIL2fqpXYI9uFD1P8zkilTkgZSgXDB5Bs5H7h-rIn8E7oi7HIsLFl3Ple7Cqt4DWXSWHC3ETcvWLU5Gmf7UNWApTJlfxhuQNVrrDDZpkpcosvM2CS6OPfVdKJBDZm7XKFUlnnZelr24uXWJJKfyMjoVsTYb8LkoHZzlr2Q',
    4.98,
    142,
    true,
    true
  ),
  (
    'Carlos Eduardo Mendes',
    'Higienização Profunda & PMOC',
    'Limpeza bactericida com protocolo ANVISA e emissão de ART para clínicas e empresas.',
    array['limpeza', 'pmoc'],
    '69055-010',
    'Parque 10',
    '(92) 98765-1122',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuAywRYIJ-eLIPLENtyqI1oN24k31UWahvSYUTf8fNYIDFims1S5g-k_BuNC2ma1aoGqhGPSSg_6FKPhULCGXJ7_I7Ao_wVZw0i57sBW2FTMtUXYs74jPNpZjdy9lTqBXUU3yy4GvtFs3m6zF4TMgl9fqk0wgqzuH302zu-mwispK5pbPbT11wMe4fDbWqujnWkdPGZVgHjTuNiO3uHQIBPnnRtsfjbGwPwe62WzfZc',
    4.90,
    87,
    true,
    true
  ),
  (
    'Juliana Vasconcelos',
    'Carga de Gás & Limpeza Preventiva',
    'Carga balanceada por peso com manifold digital e eliminação de vazamentos.',
    array['gas', 'limpeza'],
    '69053-110',
    'Vieiralves',
    '(92) 97654-3344',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuD54ajqz4GCQ6Ta8TxmzC1B68s0dJJypUDKCKZJkiHVTXXUUZsskc0HHJzjM1Yg9MsWEkF1JnMVWoddEzmGXKsbzfLTEJKjR4bEkrLBadWAxRvNUcBLmC9RvctPBlUKRtVzJdPDln5Kj8PA2whBmqhjMj4k3vX3t6t3yFQmKxgXgBdt0A-N5X0P6hVfM6e_ySh_0NTpzLMmsMJp7FqF-OL-XzXb0tHtj1xpcypH3_M',
    4.95,
    118,
    true,
    true
  ),
  (
    'Roberto Santos',
    'Manutenção & Conserto de Placas',
    'Diagnóstico elétrico especializado em tecnologia Inverter e troca de compressores.',
    array['manutencao'],
    '69037-000',
    'Ponta Negra',
    '(92) 96543-2211',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCv3nwZS9O4_26c4zAEGYq9kx0GuZYVEKbGA9ivelo7hTLBUV37PZfrA6V8lh1KTRAI_Q2ykZK10TLqX2VXC8Yke1k13TGw2jlCJdjbDFf6AX8NYpaEhOA1fZtmP92kRJDU5fN6VG1TYTj8MklFt8cyFulLL65UkAVBD4Zcvm7vQhutE970OuEWl7zw4F1TUP-y-3vDyf5NDb8cXVVzSAWNXziBgmysjCS_luD3ST4',
    4.85,
    63,
    false,
    true
  ),
  (
    'Eng. Renato Albuquerque',
    'Laudos Técnicos ART & PMOC',
    'Engenheiro mecânico responsável por projetos de climatização e cumprimento da Lei 13.589.',
    array['pmoc', 'instalacao'],
    '69058-030',
    'Flores',
    '(92) 95432-8899',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBYSVKkwgA9x7igy8XF5YXj-_vWFEQYkDaNz25XCaqCxbeSe84mIPuRH4RTzH1o3GAj3TO9hE7EPefVPusIb_B_F1581mrbcyk-YFi_C4ogO-PHS6HmOqU5yUh92U388xBJUv4u-LTUY1lJYXZDvEtUzTh0WGoafmhMJFHGGAXqr0q0Lpdp2zA2srTaxVpzxPjBjSUmqYZjdPM3qcCUlOwKkzgkOed_ZMyTIwPblnw',
    5.00,
    94,
    false,
    true
  );

-- 6. Seed inicial de Avaliações Reais
insert into public.reviews (technician_id, technician_name, client_name, client_contact, bairro, service, rating, comment, verificado)
values
  (
    1,
    'Matheus Silva',
    'Mariana Fagundes',
    '(92) 98112-3344',
    'Adrianópolis',
    'Instalação Split Inverter',
    5,
    'O Matheus foi impecável. Chegou no horário combinado pelo WhatsApp, fez teste de vácuo com equipamento digital e deixou o apartamento limpo.',
    true
  ),
  (
    2,
    'Carlos Eduardo Mendes',
    'Dr. Fernando Siqueira',
    '(92) 97234-5566',
    'Parque 10',
    'Higienização & PMOC',
    5,
    'Contratamos para a higienização da clínica. Emitiu laudo técnico detalhado e foi extremamente atencioso.',
    true
  ),
  (
    3,
    'Juliana Vasconcelos',
    'Camila Rezende',
    '(92) 99345-6677',
    'Vieiralves',
    'Recarga de Gás R410A',
    5,
    'Juliana encontrou a microfissura na tubulação que dois outros técnicos não acharam. Resolveu rápido!',
    true
  );

