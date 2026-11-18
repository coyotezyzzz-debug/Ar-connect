module.exports = (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Content-Type', 'application/json');
  res.status(200).json({
    supabaseUrl: process.env.SUPABASE_URL || 'https://cyoimmsnsndqtouezgpg.supabase.co',
    supabaseAnonKey: process.env.SUPABASE_ANON_KEY || 'sb_publishable_4Xhddi-Dvw0SYz7neqbgiQ_ZjbAEajg'
  });
};
