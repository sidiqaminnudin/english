import crypto from 'node:crypto';
export function asyncRoute(fn){return (req,res,next)=>Promise.resolve(fn(req,res,next)).catch(next);}
export function csrfSetup(req,res,next){
 if(!req.session.csrfToken)req.session.csrfToken=crypto.randomBytes(32).toString('hex');
 res.locals.csrfToken=req.session.csrfToken;
 if(['POST','PUT','PATCH','DELETE'].includes(req.method)){
  const supplied=req.get('x-csrf-token')||req.body?._csrf;
  if(typeof supplied!=='string'||supplied.length!==req.session.csrfToken.length || !crypto.timingSafeEqual(Buffer.from(supplied),Buffer.from(req.session.csrfToken)))return res.status(403).render('message',{title:'Akses ditolak',message:'Token keamanan tidak valid. Segarkan halaman lalu coba lagi.'});
 }
 next();
}
export function requireAuth(req,res,next){if(!req.session.user)return res.redirect('/login?next='+encodeURIComponent(req.originalUrl));next();}
export function requireAdmin(req,res,next){if(!req.session.user)return res.redirect('/login');if(req.session.user.role!=='admin')return res.status(403).render('message',{title:'Tidak diizinkan',message:'Halaman khusus administrator.'});next();}
export const safeNext=(v)=>typeof v==='string'&&v.startsWith('/')&&!v.startsWith('//')&&!v.includes('\\')?v:'/dashboard';
