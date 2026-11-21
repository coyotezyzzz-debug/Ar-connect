-- Migration: Adicionar coluna de senha para clientes cadastrados
-- Project: ArConnect (Manaus, AM)

alter table if exists public.clients add column if not exists password text;
