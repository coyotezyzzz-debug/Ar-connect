-- Migration: Limpeza de dados de teste para ambiente de produção
-- Project: ArConnect (Manaus, AM)

-- Remove clientes com identificação de teste
delete from public.clients where name ilike '%Teste%' or contact = '(92) 99123-4567';
