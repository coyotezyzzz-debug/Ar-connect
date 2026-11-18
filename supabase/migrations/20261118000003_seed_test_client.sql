-- Migration: Seed do Cliente de Teste no Supabase
-- Project: ArConnect (Manaus, AM)

-- Insere o cliente de teste se ainda não existir
insert into public.clients (name, contact, cep, bairro)
select 'Carlos Augusto (Cliente Teste)', '(92) 99123-4567', '69057-000', 'Adrianópolis'
where not exists (select 1 from public.clients where contact = '(92) 99123-4567');
