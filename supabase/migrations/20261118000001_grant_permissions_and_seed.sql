-- Migration: ArConnect Permissions & Idempotent Seed
-- Project: ArConnect (Manaus, AM)

-- 1. Permissões de Acesso para a API (anon, authenticated e service_role)
grant usage on schema public to anon, authenticated, service_role;

grant all on table public.technicians to anon, authenticated, service_role;
grant all on table public.reviews to anon, authenticated, service_role;
grant all on table public.bookings to anon, authenticated, service_role;
grant all on table public.clients to anon, authenticated, service_role;

grant all on all sequences in schema public to anon, authenticated, service_role;

-- 2. Seed idempotente de Técnicos Homologados de Manaus
insert into public.technicians (nome, especialidade, descricao, categorias, cep, bairro, whatsapp, foto, avaliacao, atendimentos, urgente, verificado)
select 'Matheus Silva', 'Instalação Split & Inverter', 'Atendimento técnico residencial e comercial com teste de estanqueidade e vácuo.', array['instalacao', 'manutencao'], '69057-000', 'Adrianópolis', '(92) 99821-4402', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCrD9Q71351UvQUcfyiYUt7RNYQ4sdeNkX2ecTKdjK7K2tQtem0yx_zMAwazOunHpBZ8WIL2fqpXYI9uFD1P8zkilTkgZSgXDB5Bs5H7h-rIn8E7oi7HIsLFl3Ple7Cqt4DWXSWHC3ETcvWLU5Gmf7UNWApTJlfxhuQNVrrDDZpkpcosvM2CS6OPfVdKJBDZm7XKFUlnnZelr24uXWJJKfyMjoVsTYb8LkoHZzlr2Q', 4.98, 142, true, true
where not exists (select 1 from public.technicians where nome = 'Matheus Silva');

insert into public.technicians (nome, especialidade, descricao, categorias, cep, bairro, whatsapp, foto, avaliacao, atendimentos, urgente, verificado)
select 'Carlos Eduardo Mendes', 'Higienização Profunda & PMOC', 'Limpeza bactericida com protocolo ANVISA e emissão de ART para clínicas e empresas.', array['limpeza', 'pmoc'], '69055-010', 'Parque 10', '(92) 98765-1122', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAywRYIJ-eLIPLENtyqI1oN24k31UWahvSYUTf8fNYIDFims1S5g-k_BuNC2ma1aoGqhGPSSg_6FKPhULCGXJ7_I7Ao_wVZw0i57sBW2FTMtUXYs74jPNpZjdy9lTqBXUU3yy4GvtFs3m6zF4TMgl9fqk0wgqzuH302zu-mwispK5pbPbT11wMe4fDbWqujnWkdPGZVgHjTuNiO3uHQIBPnnRtsfjbGwPwe62WzfZc', 4.90, 87, true, true
where not exists (select 1 from public.technicians where nome = 'Carlos Eduardo Mendes');

insert into public.technicians (nome, especialidade, descricao, categorias, cep, bairro, whatsapp, foto, avaliacao, atendimentos, urgente, verificado)
select 'Juliana Vasconcelos', 'Carga de Gás & Limpeza Preventiva', 'Carga balanceada por peso com manifold digital e eliminação de vazamentos.', array['gas', 'limpeza'], '69053-110', 'Vieiralves', '(92) 97654-3344', 'https://lh3.googleusercontent.com/aida-public/AB6AXuD54ajqz4GCQ6Ta8TxmzC1B68s0dJJypUDKCKZJkiHVTXXUUZsskc0HHJzjM1Yg9MsWEkF1JnMVWoddEzmGXKsbzfLTEJKjR4bEkrLBadWAxRvNUcBLmC9RvctPBlUKRtVzJdPDln5Kj8PA2whBmqhjMj4k3vX3t6t3yFQmKxgXgBdt0A-N5X0P6hVfM6e_ySh_0NTpzLMmsMJp7FqF-OL-XzXb0tHtj1xpcypH3_M', 4.95, 118, true, true
where not exists (select 1 from public.technicians where nome = 'Juliana Vasconcelos');

insert into public.technicians (nome, especialidade, descricao, categorias, cep, bairro, whatsapp, foto, avaliacao, atendimentos, urgente, verificado)
select 'Roberto Santos', 'Manutenção & Conserto de Placas', 'Diagnóstico elétrico especializado em tecnologia Inverter e troca de compressores.', array['manutencao'], '69037-000', 'Ponta Negra', '(92) 96543-2211', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCv3nwZS9O4_26c4zAEGYq9kx0GuZYVEKbGA9ivelo7hTLBUV37PZfrA6V8lh1KTRAI_Q2ykZK10TLqX2VXC8Yke1k13TGw2jlCJdjbDFf6AX8NYpaEhOA1fZtmP92kRJDU5fN6VG1TYTj8MklFt8cyFulLL65UkAVBD4Zcvm7vQhutE970OuEWl7zw4F1TUP-y-3vDyf5NDb8cXVVzSAWNXziBgmysjCS_luD3ST4', 4.85, 63, false, true
where not exists (select 1 from public.technicians where nome = 'Roberto Santos');

insert into public.technicians (nome, especialidade, descricao, categorias, cep, bairro, whatsapp, foto, avaliacao, atendimentos, urgente, verificado)
select 'Eng. Renato Albuquerque', 'Laudos Técnicos ART & PMOC', 'Engenheiro mecânico responsável por projetos de climatização e cumprimento da Lei 13.589.', array['pmoc', 'instalacao'], '69058-030', 'Flores', '(92) 95432-8899', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBYSVKkwgA9x7igy8XF5YXj-_vWFEQYkDaNz25XCaqCxbeSe84mIPuRH4RTzH1o3GAj3TO9hE7EPefVPusIb_B_F1581mrbcyk-YFi_C4ogO-PHS6HmOqU5yUh92U388xBJUv4u-LTUY1lJYXZDvEtUzTh0WGoafmhMJFHGGAXqr0q0Lpdp2zA2srTaxVpzxPjBjSUmqYZjdPM3qcCUlOwKkzgkOed_ZMyTIwPblnw', 5.00, 94, false, true
where not exists (select 1 from public.technicians where nome = 'Eng. Renato Albuquerque');

-- 3. Seed idempotente de Avaliações
insert into public.reviews (technician_name, client_name, client_contact, bairro, service, rating, comment, verificado)
select 'Matheus Silva', 'Mariana Fagundes', '(92) 98112-3344', 'Adrianópolis', 'Instalação Split Inverter', 5, 'O Matheus foi impecável. Chegou no horário combinado pelo WhatsApp, fez teste de vácuo com equipamento digital e deixou o apartamento limpo.', true
where not exists (select 1 from public.reviews where client_name = 'Mariana Fagundes');

insert into public.reviews (technician_name, client_name, client_contact, bairro, service, rating, comment, verificado)
select 'Carlos Eduardo Mendes', 'Dr. Fernando Siqueira', '(92) 97234-5566', 'Parque 10', 'Higienização & PMOC', 5, 'Contratamos para a higienização da clínica. Emitiu laudo técnico detalhado e foi extremamente atencioso.', true
where not exists (select 1 from public.reviews where client_name = 'Dr. Fernando Siqueira');

insert into public.reviews (technician_name, client_name, client_contact, bairro, service, rating, comment, verificado)
select 'Juliana Vasconcelos', 'Camila Rezende', '(92) 99345-6677', 'Vieiralves', 'Recarga de Gás R410A', 5, 'Juliana encontrou a microfissura na tubulação que dois outros técnicos não acharam. Resolveu rápido!', true
where not exists (select 1 from public.reviews where client_name = 'Camila Rezende');
