$folder = 'c:\Users\tcabb\OneDrive\Documents\Baby Shower Invite'

function Get-B64($name) {
  $path = Join-Path $folder ($name + '.b64.txt')
  return (Get-Content $path -Raw).Trim()
}

$sulley   = Get-B64 'cute James P. Sullivan.jpg'
$furbg    = Get-B64 'James P. Sullivan furr bg.jpg'
$us1       = Get-B64 'ultrasound image 1.png'
$us2       = Get-B64 'ultrasound image 2.png'
$partyDecor = Get-B64 'party decor James P. Sullivan.jpeg'

$sideBubblesSvg = (Get-Content -LiteralPath (Join-Path $folder 'bubbles-parallax.svg') -Raw) -replace '(?s)^.*?(<svg)','$1'
$starSparkleSvg  = (Get-Content -LiteralPath (Join-Path $folder 'star-sparkle.svg') -Raw) -replace '(?s)^.*?(<svg)','$1'
$ribbonDecorSvg  = (Get-Content -LiteralPath (Join-Path $folder 'ribbon-decor.svg') -Raw) -replace '(?s)^.*?(<svg)','$1'
$cloudDecoSvg    = (Get-Content -LiteralPath (Join-Path $folder 'cloud-deco.svg') -Raw) -replace '(?s)^.*?(<svg)','$1'
$bottleCapDecoSvg   = (Get-Content -LiteralPath (Join-Path $folder 'bottle-cap-deco.svg') -Raw) -replace '(?s)^.*?(<svg)','$1'
$babyShowerTextSvg  = (Get-Content -LiteralPath (Join-Path $folder 'baby-shower-text.svg') -Raw) -replace '(?s)^.*?(<svg)','$1'
$sulleyCharSvg = (Get-Content -LiteralPath (Join-Path $folder 'sulley-char.svg') -Raw) -replace '(?s)^.*?(<svg)','$1'

$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Baby Shower Invitation - Izan Theodore Waight</title>
<meta name="description" content="You are invited to Baby Izan Theodore Waight's Baby Shower! June 13th, 1-5pm, Belmopan Maya Mopan.">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&family=Nunito:wght@400;600;700&family=Dancing+Script:wght@600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --sulley-blue:#5CC6D0;
    --sulley-blue-dark:#2E8FA3;
    --sulley-purple:#7B4FA3;
    --sulley-purple-dark:#5B2E7E;
  }
  *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
  html{scroll-behavior:smooth}
  body{font-family:'Nunito',sans-serif;background:#0a1a2e;overflow-x:hidden;will-change:scroll-position}

  /* ── SECTION 1: HERO REVEAL ── */
  #s1{
    position:relative;min-height:100vh;display:flex;flex-direction:column;
    align-items:center;justify-content:center;overflow:hidden;background:#0a1a2e;
    will-change:transform;transform:translateZ(0);backface-visibility:hidden;
  }
  .party-hero-bg{
    position:absolute;inset:0;
    background-image:url('$partyDecor');
    background-size:cover;background-position:center;z-index:0;
  }
  .party-hero-bg::after{
    content:'';position:absolute;inset:0;
    background:linear-gradient(180deg,rgba(10,26,46,.55),rgba(10,26,46,.3) 40%,rgba(10,26,46,.65) 80%,#0a1a2e);
    pointer-events:none;
  }
  /* ── SVG stars ── */
  #stars{position:absolute;inset:0;width:100%;height:100%;z-index:1;pointer-events:none}
  #stars .sd{fill:#fff;animation:twinkle 2s infinite alternate;will-change:opacity}
  #stars .sd:nth-child(2n){animation-delay:.3s;animation-duration:1.7s}
  #stars .sd:nth-child(3n){animation-delay:.7s;animation-duration:2.3s}
  #stars .sd:nth-child(5n){animation-delay:1.1s;animation-duration:1.9s}
  #stars .sd:nth-child(7n){animation-delay:.5s;animation-duration:2.1s}
  #stars .sd:nth-child(11n){animation-delay:1.4s;animation-duration:1.5s}
  @keyframes twinkle{0%{opacity:.2}100%{opacity:1}}

  /* ── SVG baby particles ── */
  #baby-particles{position:absolute;inset:0;width:100%;height:100%;z-index:1;pointer-events:none}
  #baby-particles .pd{animation:floatBaby 4.5s ease-in-out infinite;will-change:transform}
  #baby-particles .pd:nth-child(2n){animation-delay:.8s;animation-duration:5.2s}
  #baby-particles .pd:nth-child(3n){animation-delay:1.5s;animation-duration:3.8s}
  #baby-particles .pd:nth-child(5n){animation-delay:.4s;animation-duration:4.1s}
  @keyframes floatBaby{0%,100%{transform:translateY(0) rotate(0)}25%{transform:translateY(-12px) rotate(4deg)}75%{transform:translateY(-6px) rotate(-3deg)}}

  /* ── Section decorations (SVGs inside sections, parallax scroll) ── */
  .deco{position:absolute;pointer-events:none;z-index:1;backface-visibility:hidden;will-change:transform,opacity;opacity:0}
  .deco svg{display:block;height:auto}
  .deco-l{left:clamp(10px,2.5vw,28px)}
  .deco-r{right:clamp(10px,2.5vw,28px)}
  .deco-bub svg{width:clamp(65px,9vw,110px)}
  .deco-spark svg{width:clamp(65px,9vw,110px)}
  .deco-rib svg{width:clamp(55px,7.5vw,90px)}
  .deco-cld svg{width:clamp(50px,7vw,85px)}
  .deco-cap svg{width:clamp(55px,7.5vw,90px)}

  #s1 .deco-bub{bottom:4%;left:clamp(6px,1.5vw,16px)}
  #s1 .deco-spark{top:4%}
  #s2 .deco-cld{top:50%;left:clamp(6px,1.5vw,16px);margin-top:-42px}
  #s3 .deco-rib{bottom:5%;left:clamp(6px,1.5vw,16px)}
  #s3 .deco-cap{top:5%}

  /* ── Parallax Layer ── */
  .parallax-bg{position:absolute;inset:0;z-index:0;pointer-events:none;will-change:transform;background:radial-gradient(ellipse at 20% 50%,rgba(92,198,208,.06) 0,transparent 50%),radial-gradient(ellipse at 80% 30%,rgba(123,79,163,.05) 0,transparent 50%)}

  /* ── Intro Overlay (click to reveal) ── */
  .intro-overlay{position:fixed;inset:0;z-index:100;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:2rem;cursor:pointer;background:#0a1a2e;will-change:transform;transition:transform .9s cubic-bezier(.65,0,.35,1),opacity .9s ease}
  .intro-overlay.hidden{transform:translateY(-100vh);opacity:0;pointer-events:none}
  .intro-badge svg{display:block;width:clamp(160px,30vw,400px);height:auto}
  .intro-card{position:relative;border-radius:18px;overflow:hidden;border:3px solid var(--sulley-blue);box-shadow:0 0 60px rgba(92,198,208,.5),0 0 120px rgba(123,79,163,.3);width:min(340px,55vw);will-change:transform;transition:transform 1s cubic-bezier(.22,1,.36,1)}
  .intro-overlay.hidden .intro-card{transform:scale(1.4) rotate(-6deg)}
  .intro-card img{width:100%;display:block}
  .intro-card-badge{position:absolute;bottom:0;left:0;right:0;padding:1.2rem .8rem .8rem;background:linear-gradient(transparent,rgba(0,0,0,.85));color:#7efff5;font-family:'Courier New',monospace;font-size:.8rem;letter-spacing:.08em;text-align:center}
  .intro-loading-wrap{position:absolute;bottom:2.4rem;left:50%;transform:translateX(-50%);display:flex;flex-direction:column;align-items:center;gap:6px}
  .intro-loading-bar{width:clamp(120px,20vw,200px);height:3px;background:rgba(255,255,255,.08);border-radius:4px;overflow:hidden;position:relative}
  .intro-loading-bar::after{content:'';position:absolute;top:0;left:-50%;width:50%;height:100%;background:linear-gradient(90deg,transparent,var(--sulley-blue),var(--sulley-purple),transparent);border-radius:4px;animation:loadingSweep 1.6s ease-in-out infinite;will-change:transform}
  @keyframes loadingSweep{0%{left:-50%}100%{left:100%}}
  .intro-loading-txt{font-size:.6rem;color:rgba(255,255,255,.25);letter-spacing:.3em;text-transform:uppercase}
  .tap-hint{font-family:'Nunito',sans-serif;font-size:.85rem;color:rgba(255,255,255,.4);letter-spacing:.25em;text-transform:uppercase;animation:hintPulse 2s ease-in-out infinite;will-change:transform}
  @keyframes hintPulse{0%,100%{opacity:.4;transform:scale(1)}50%{opacity:.9;transform:scale(1.05)}}

  /* ── Revealed content (behind overlay) ── */
  .reveal-content{position:relative;z-index:2;text-align:center;padding:2rem clamp(3.5rem,6vw,5rem);display:flex;flex-direction:column;align-items:center;gap:1.5rem;will-change:transform;transform:translateZ(0)}
  .its-a-boy{font-family:'Baloo 2',cursive;font-size:clamp(3rem,13vw,8.5rem);font-weight:800;line-height:1;background:linear-gradient(135deg,var(--sulley-blue),var(--sulley-purple));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;opacity:0;transform:scale(.4) rotate(-8deg);filter:blur(12px);will-change:transform,opacity,filter}
  .its-a-boy.revealed{animation:boyBurst 1s cubic-bezier(.22,1,.36,1) forwards}
  @keyframes boyBurst{0%{opacity:0;transform:scale(.4) rotate(-8deg);filter:blur(12px)}50%{opacity:1;transform:scale(1.12) rotate(1deg);filter:blur(0)}100%{opacity:1;transform:scale(1) rotate(0);filter:blur(0);filter:drop-shadow(0 0 60px rgba(92,198,208,.7)) drop-shadow(0 0 100px rgba(123,79,163,.4))}}
  .script-invite{font-family:'Dancing Script',cursive;font-size:clamp(1.7rem,6vw,3.6rem);color:rgba(255,255,255,.85);line-height:1.5;opacity:0;transform:translateY(30px)}
  .script-invite.reveal-in{animation:scriptFade .8s .15s cubic-bezier(.22,1,.36,1) forwards}
  @keyframes scriptFade{0%{opacity:0;transform:translateY(30px)}100%{opacity:1;transform:translateY(0)}}
  .script-name{font-family:'Dancing Script',cursive;font-size:clamp(3.5rem,14vw,9rem);font-weight:700;color:#fff;opacity:0;transform:translateY(20px) scale(.9);text-shadow:0 0 40px rgba(92,198,208,.5)}
  .script-name.reveal-in{animation:nameFade .9s .3s cubic-bezier(.22,1,.36,1) forwards}
  @keyframes nameFade{0%{opacity:0;transform:translateY(20px) scale(.8)}60%{opacity:1;transform:translateY(-5px) scale(1.05)}100%{opacity:1;transform:translateY(0) scale(1)}}
  .sulley-hero-svg{width:min(180px,40vw);padding:6px;border-radius:18px;box-shadow:0 0 40px rgba(92,198,208,.5),0 0 80px rgba(123,79,163,.3);opacity:0;transform:scale(.6);background:rgba(255,255,255,.04);backdrop-filter:blur(4px)}
  .sulley-hero-svg.reveal-in{animation:sulleyFade .9s .45s ease-out forwards}
  .sulley-hero-svg svg{display:block;width:100%;height:auto}
  .sulley-hero-svg svg path{opacity:0;animation:svgPathFade .5s ease forwards}
  .sulley-hero-svg.reveal-in svg path:nth-child(7n+1){animation-delay:.45s}
  .sulley-hero-svg.reveal-in svg path:nth-child(7n+2){animation-delay:.52s}
  .sulley-hero-svg.reveal-in svg path:nth-child(7n+3){animation-delay:.59s}
  .sulley-hero-svg.reveal-in svg path:nth-child(7n+4){animation-delay:.66s}
  .sulley-hero-svg.reveal-in svg path:nth-child(7n+5){animation-delay:.73s}
  .sulley-hero-svg.reveal-in svg path:nth-child(7n+6){animation-delay:.80s}
  .sulley-hero-svg.reveal-in svg path:nth-child(7n+7){animation-delay:.87s}
  @keyframes sulleyFade{0%{opacity:0;transform:scale(.85)}100%{opacity:1;transform:scale(1)}}
  @keyframes svgPathFade{0%{opacity:0}100%{opacity:1}}

  .scroll-hint{position:absolute;bottom:2rem;left:50%;transform:translateX(-50%);z-index:3;display:flex;flex-direction:column;align-items:center;gap:.4rem;color:var(--sulley-blue);font-size:.8rem;letter-spacing:.15em;animation:bounce 1.5s infinite;white-space:nowrap;will-change:transform;opacity:0;transition:opacity .6s ease}
  .scroll-hint svg{width:22px;height:22px}
  @keyframes bounce{0%,100%{transform:translateX(-50%) translateY(0)}50%{transform:translateX(-50%) translateY(8px)}}

  /* ── SECTION 2: INTRO ── */
  #s2{min-height:30vh;display:flex;align-items:center;justify-content:center;background:linear-gradient(180deg,#0a1a2e,#0c1f38);padding:3rem clamp(3rem,6vw,5rem)}
  .us-sub{font-family:'Baloo 2',cursive;font-size:clamp(1.6rem,5vw,2.8rem);color:#fff;text-align:center;opacity:0;transform:translateY(20px);will-change:opacity,transform}
  .us-sub b{color:var(--sulley-blue)}

  /* ── SECTION 3: INVITE ── */
  #s3{position:relative;padding:5rem 1rem;background-image:url('$furbg');background-size:cover;background-attachment:fixed;background-position:center}
  #s3::before{content:'';position:absolute;inset:0;background:rgba(8,20,38,.85)}
  .invite-wrap{position:relative;z-index:1;max-width:700px;margin:0 auto;padding:0 clamp(1rem,2vw,2rem)}
  .card{background:rgba(255,255,255,.04);backdrop-filter:blur(18px);border:2px solid rgba(92,198,208,.35);border-radius:32px;padding:3rem 2rem;text-align:center;box-shadow:0 8px 60px rgba(0,0,0,.5),inset 0 1px 0 rgba(255,255,255,.08);opacity:0;transform:translateY(40px);will-change:opacity,transform}
  .pre-label{font-size:.8rem;color:var(--sulley-blue);letter-spacing:.25em;text-transform:uppercase;margin-bottom:.4rem}
  .hosts{font-family:'Baloo 2',cursive;font-size:clamp(1.5rem,4vw,2.4rem);color:#fff;font-weight:800;margin-bottom:1.4rem}
  .divider{width:80px;height:3px;background:linear-gradient(90deg,var(--sulley-purple),var(--sulley-blue));border-radius:2px;margin:0 auto 1.4rem}
  .invite-sub{font-size:.95rem;color:rgba(255,255,255,.7);letter-spacing:.1em;text-transform:uppercase;margin-bottom:.5rem}
  .baby-name{font-family:'Baloo 2',cursive;font-size:clamp(2.2rem,7vw,4rem);font-weight:800;background:linear-gradient(135deg,var(--sulley-blue),var(--sulley-purple));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1.1;margin-bottom:.3rem}
  .shower-tag{font-family:'Baloo 2',cursive;font-size:1.3rem;color:#fff;margin-bottom:2rem}
  .details{display:grid;grid-template-columns:repeat(auto-fit,minmax(130px,1fr));gap:.9rem;margin:1.5rem 0}
  .det{background:rgba(92,198,208,.09);border:1px solid rgba(92,198,208,.28);border-radius:16px;padding:1rem .7rem;display:flex;flex-direction:column;align-items:center;gap:.3rem;opacity:0;transform:translateY(20px);will-change:transform,opacity}
  .det-icon{width:2rem;height:2rem;display:inline-flex;align-items:center;justify-content:center;will-change:transform}
  .det-icon svg{width:100%;height:100%}
  .det-lbl{font-size:.65rem;color:var(--sulley-blue);letter-spacing:.2em;text-transform:uppercase}
  .det-val{font-family:'Baloo 2',cursive;font-size:1rem;color:#fff;font-weight:600;line-height:1.2}
  .cd-label{font-size:.75rem;color:var(--sulley-blue);letter-spacing:.2em;text-transform:uppercase;margin:2rem 0 .8rem}
  .cd{display:flex;justify-content:center;gap:1rem;flex-wrap:wrap}
  .cdu{display:flex;flex-direction:column;align-items:center;gap:.25rem}
  .cdn{font-family:'Baloo 2',cursive;font-size:clamp(1.8rem,5vw,2.8rem);font-weight:800;color:#fff;background:linear-gradient(180deg,var(--sulley-purple),var(--sulley-purple-dark));border-radius:12px;width:68px;height:68px;display:flex;align-items:center;justify-content:center;box-shadow:0 4px 20px rgba(123,79,163,.5);transition:transform .2s}
  .cdn:hover{transform:scale(1.06)}
  .cdl{font-size:.6rem;color:rgba(255,255,255,.55);letter-spacing:.12em;text-transform:uppercase}
  .rsvp-btn{display:inline-block;margin:2rem auto 0;padding:.8rem 2.4rem;background:linear-gradient(135deg,var(--sulley-blue),var(--sulley-purple));border-radius:50px;color:#fff;font-family:'Baloo 2',cursive;font-size:1.2rem;font-weight:700;text-decoration:none;letter-spacing:.04em;box-shadow:0 4px 30px rgba(92,198,208,.4);transition:transform .2s,box-shadow .2s}
  .rsvp-btn:hover{transform:scale(1.06);box-shadow:0 6px 40px rgba(92,198,208,.6)}
  .rsvp-btn:active{transform:scale(.97)}
  .rsvp-note{margin-top:2rem;padding:1rem 1.2rem;background:rgba(123,79,163,.15);border:1px solid rgba(123,79,163,.35);border-radius:14px;color:rgba(255,255,255,.7);font-size:.9rem;line-height:1.6}
  .rsvp-note strong{color:var(--sulley-blue)}

  /* ── Big loading bar decoration ── */
  .deco-load-wrap{position:relative;z-index:1;display:flex;flex-direction:column;align-items:center;gap:1rem;margin:3rem auto 0;max-width:500px}
  .deco-load-track{width:100%;height:16px;background:rgba(255,255,255,.05);border-radius:12px;overflow:hidden;position:relative;box-shadow:inset 0 2px 4px rgba(0,0,0,.3)}
  .deco-load-fill{height:100%;border-radius:12px;background:linear-gradient(90deg,var(--sulley-blue),var(--sulley-purple));position:relative;animation:decoLoad 3s ease-in-out infinite;will-change:transform}
  .deco-load-fill::after{content:'';position:absolute;top:0;left:0;right:0;bottom:0;border-radius:12px;background:linear-gradient(90deg,transparent,rgba(255,255,255,.35),transparent);animation:decoShine 2s ease-in-out infinite;will-change:transform}
  @keyframes decoLoad{0%{width:8%}50%{width:92%}100%{width:8%}}
  @keyframes decoShine{0%{transform:translateX(-100%)}100%{transform:translateX(100%)}}
  .deco-load-stars{display:flex;gap:.6rem;align-items:center}
  .deco-load-stars svg{width:16px;height:16px;animation:starTwinkle 1.8s ease-in-out infinite alternate;will-change:opacity}
  .deco-load-stars svg:nth-child(2){animation-delay:.5s}
  .deco-load-stars svg:nth-child(3){animation-delay:1s}
  @keyframes starTwinkle{0%{opacity:.3}100%{opacity:1}}

  /* ── FOOTER ── */
  footer{text-align:center;padding:3rem 1rem 4rem;background:#060f1e}
  footer img{width:min(160px,38vw);border-radius:50%;opacity:.9;filter:drop-shadow(0 0 20px rgba(92,198,208,.5));animation:float 3s ease-in-out infinite}
  @keyframes float{0%,100%{transform:translateY(0)}50%{transform:translateY(-10px)}}
  .foot-txt{font-family:'Baloo 2',cursive;color:var(--sulley-blue);font-size:1.1rem;margin-top:.8rem}
  .foot-names{font-family:'Baloo 2',cursive;color:rgba(255,255,255,.5);font-size:.85rem;margin-top:.3rem}

  @media(max-width:480px){.card{padding:2rem 1rem}.cdn{width:56px;height:56px}}

  @media (prefers-reduced-motion:reduce){
    *{animation-duration:.01ms!important;animation-iteration-count:1!important;transition-duration:.01ms!important}
    .intro-overlay{display:none}
    .det,.parallax-bg,.its-a-boy{opacity:1!important;transform:none!important}
    .script-invite,.script-name,.sulley-hero-svg,.us-sub{opacity:1!important;transform:none!important}
  }
</style>
</head>
<body style="overflow:hidden">

<!-- Decorations are placed inside each section below -->

<!-- ── Intro Overlay (click to reveal) ── -->
<div class="intro-overlay" id="intro-overlay">
  <div class="intro-badge">$babyShowerTextSvg</div>
  <div class="intro-card" id="intro-card">
    <img src="$us1" alt="Ultrasound scan of baby Izan Theodore Waight">
    <div class="intro-card-badge"><svg viewBox="0 0 24 24" width="12" height="12" fill="#7efff5" style="vertical-align:middle;margin-right:2px"><path d="M12 0l1.5 8.5L22 10l-8.5 1.5L12 20l-1.5-8.5L2 10l8.5-1.5z"/></svg> IZAN THEODORE WAIGHT &nbsp;<svg viewBox="0 0 24 24" width="12" height="12" fill="#7efff5" style="vertical-align:middle;margin:0 2px"><path d="M12 0l1.5 8.5L22 10l-8.5 1.5L12 20l-1.5-8.5L2 10l8.5-1.5z"/></svg>&nbsp; &male; BABY BOY</div>
  </div>
  <div class="intro-loading-wrap">
    <div class="intro-loading-bar"></div>
    <span class="intro-loading-txt">baby boy loading</span>
  </div>
  <p class="tap-hint" id="tap-hint"><svg viewBox="0 0 24 24" width="10" height="10" fill="currentColor" style="vertical-align:middle;margin-right:4px"><path d="M12 0l1.5 8.5L22 10l-8.5 1.5L12 20l-1.5-8.5L2 10l8.5-1.5z"/></svg> tap to reveal <svg viewBox="0 0 24 24" width="10" height="10" fill="currentColor" style="vertical-align:middle;margin-left:4px"><path d="M12 0l1.5 8.5L22 10l-8.5 1.5L12 20l-1.5-8.5L2 10l8.5-1.5z"/></svg></p>
</div>

<!-- ── SECTION 1: HERO ── -->
<section id="s1">
  <div class="deco deco-l deco-bub">$sideBubblesSvg</div>
  <div class="deco deco-r deco-spark">$starSparkleSvg</div>
  <div class="party-hero-bg"></div>
  <!-- SVG stars -->
  <svg id="stars" viewBox="0 0 1000 600" preserveAspectRatio="none">
    <defs><circle id="sd" r="1.5" class="sd" /></defs>
    <use href="#sd" x="45" y="28"/><use href="#sd" x="138" y="87"/><use href="#sd" x="220" y="42"/>
    <use href="#sd" x="315" y="115"/><use href="#sd" x="410" y="33"/><use href="#sd" x="505" y="92"/>
    <use href="#sd" x="600" y="18"/><use href="#sd" x="695" y="105"/><use href="#sd" x="788" y="55"/>
    <use href="#sd" x="882" y="120"/><use href="#sd" x="960" y="45"/><use href="#sd" x="72" y="185"/>
    <use href="#sd" x="185" y="230"/><use href="#sd" x="290" y="170"/><use href="#sd" x="380" y="250"/>
    <use href="#sd" x="470" y="190"/><use href="#sd" x="555" y="260"/><use href="#sd" x="650" y="175"/>
    <use href="#sd" x="740" y="240"/><use href="#sd" x="830" y="160"/><use href="#sd" x="920" y="235"/>
    <use href="#sd" x="30" y="360"/><use href="#sd" x="120" y="320"/><use href="#sd" x="210" y="390"/>
    <use href="#sd" x="330" y="340"/><use href="#sd" x="440" y="370"/><use href="#sd" x="520" y="330"/>
    <use href="#sd" x="630" y="390"/><use href="#sd" x="720" y="320"/><use href="#sd" x="810" y="380"/>
    <use href="#sd" x="930" y="350"/><use href="#sd" x="90" y="480"/><use href="#sd" x="200" y="520"/>
    <use href="#sd" x="350" y="470"/><use href="#sd" x="460" y="530"/><use href="#sd" x="580" y="490"/>
    <use href="#sd" x="680" y="540"/><use href="#sd" x="790" y="480"/><use href="#sd" x="890" y="530"/>
    <use href="#sd" x="970" y="470"/>
  </svg>
  <!-- SVG baby particles -->
  <svg id="baby-particles" viewBox="0 0 1000 600" preserveAspectRatio="none">
    <defs>
      <path id="hrt" d="M0,4 A4,4,0,0,1,8,0 A4,4,0,0,1,16,4 Q16,10,8,16 Q0,10,0,4"/>
      <polygon id="dia" points="7,0 14,7 7,14 0,7"/>
      <path id="spk" d="M8,0 L9,6 L15,7 L9,8 L8,14 L7,8 L1,7 L7,6 Z"/>
    </defs>
    <use href="#hrt" x="100" y="80" class="pd" fill="rgba(255,255,255,.12)"/>
    <use href="#dia" x="300" y="200" class="pd" fill="rgba(92,198,208,.18)"/>
    <use href="#spk" x="500" y="100" class="pd" fill="rgba(255,255,255,.1)"/>
    <use href="#hrt" x="700" y="300" class="pd" fill="rgba(123,79,163,.15)"/>
    <use href="#spk" x="800" y="150" class="pd" fill="rgba(250,193,130,.18)"/>
    <use href="#dia" x="200" y="420" class="pd" fill="rgba(92,198,208,.14)"/>
    <use href="#spk" x="650" y="450" class="pd" fill="rgba(255,255,255,.1)"/>
    <use href="#hrt" x="900" y="350" class="pd" fill="rgba(123,79,163,.12)"/>
    <use href="#dia" x="400" y="500" class="pd" fill="rgba(250,193,130,.1)"/>
    <use href="#spk" x="150" y="280" class="pd" fill="rgba(92,198,208,.15)"/>
  </svg>
  <div class="parallax-bg"></div>
  <div class="reveal-content">
    <h1 class="its-a-boy" id="boy-heading">IT'S A BOY!</h1>
    <p class="script-invite" id="script-invite">Jess &amp; Adriel Waight<br>invites you to<br>the baby shower for</p>
    <p class="script-name" id="script-name">Izan</p>
    <div class="sulley-hero-svg">$sulleyCharSvg</div>
  </div>
  <div class="scroll-hint" id="scroll-hint">
    <span>SCROLL</span>
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
      <path d="M12 5v14M5 12l7 7 7-7"/>
    </svg>
  </div>
</section>

<!-- ── SECTION 2: INTRO ── -->
<section id="s2">
  <div class="deco deco-l deco-cld">$cloudDecoSvg</div>
  <p class="us-sub" id="us-sub">Hello, little <b>Izan Theodore</b></p>
</section>

<!-- ── SECTION 3: INVITATION ── -->
<section id="s3">
  <div class="deco deco-l deco-rib">$ribbonDecorSvg</div>
  <div class="deco deco-r deco-cap">$bottleCapDecoSvg</div>
  <div class="invite-wrap">
    <article class="card" id="invite-card">

      <p class="pre-label">Jess &amp; Adriel Waight cordially invite you to</p>
      <h2 class="hosts">The Baby Shower of</h2>
      <div class="divider"></div>

      <p class="invite-sub">introducing</p>
      <h3 class="baby-name">Baby Izan<br>Theodore Waight</h3>
      <p class="shower-tag">Baby Shower Celebration</p>

      <div class="details">
        <div class="det" style="--i:1">
          <span class="det-icon"><svg viewBox="0 0 24 24" fill="none" stroke="var(--sulley-blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg></span>
          <span class="det-lbl">Date</span>
          <span class="det-val">June 13th, 2026</span>
        </div>
        <div class="det" style="--i:2">
          <span class="det-icon"><svg viewBox="0 0 24 24" fill="none" stroke="var(--sulley-blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg></span>
          <span class="det-lbl">Time</span>
          <span class="det-val">1:00 PM &ndash; 5:00 PM</span>
        </div>
        <div class="det" style="--i:3">
          <span class="det-icon"><svg viewBox="0 0 24 24" fill="none" stroke="var(--sulley-blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></span>
          <span class="det-lbl">Location</span>
          <span class="det-val">Belmopan,<br>Maya Mopan</span>
        </div>
      </div>

      <p class="cd-label"><svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="var(--sulley-blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:4px"><path d="M5 22h14"/><path d="M5 2h14"/><path d="M17 22v-5l-2.5-3.5L17 10V8"/><path d="M7 22v-5l2.5-3.5L7 10V8"/><path d="M12 22V8"/><path d="M8 5V2"/><path d="M16 5V2"/></svg> Counting Down to Baby Day</p>
      <div class="cd" id="cd" role="timer" aria-live="polite">
        <div class="cdu"><div class="cdn" id="cd-d">--</div><span class="cdl">Days</span></div>
        <div class="cdu"><div class="cdn" id="cd-h">--</div><span class="cdl">Hours</span></div>
        <div class="cdu"><div class="cdn" id="cd-m">--</div><span class="cdl">Mins</span></div>
        <div class="cdu"><div class="cdn" id="cd-s">--</div><span class="cdl">Secs</span></div>
      </div>

      <a class="rsvp-btn" href="rsvp.html">RSVP Now</a>

      <div class="rsvp-note">
        We can't wait to celebrate with you! <svg viewBox="0 0 24 24" width="16" height="16" fill="var(--sulley-blue)" style="vertical-align:middle"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg><svg viewBox="0 0 24 24" width="16" height="16" fill="var(--sulley-purple)" style="vertical-align:middle"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg><br>
        <strong>Jess &amp; Adriel Waight</strong> &mdash; Belmopan, Maya Mopan
      </div>

    </article>

    <div class="deco-load-wrap">
      <div class="deco-load-track">
        <div class="deco-load-fill"></div>
      </div>
      <div class="deco-load-stars">
        <svg viewBox="0 0 24 24" fill="var(--sulley-blue)"><path d="M12 0l1.5 8.5L22 10l-8.5 1.5L12 20l-1.5-8.5L2 10l8.5-1.5z"/></svg>
        <svg viewBox="0 0 24 24" fill="var(--sulley-purple)"><path d="M12 0l1.5 8.5L22 10l-8.5 1.5L12 20l-1.5-8.5L2 10l8.5-1.5z"/></svg>
        <svg viewBox="0 0 24 24" fill="var(--sulley-blue)"><path d="M12 0l1.5 8.5L22 10l-8.5 1.5L12 20l-1.5-8.5L2 10l8.5-1.5z"/></svg>
      </div>
    </div>
  </div>
</section>

<!-- ── FOOTER ── -->
<footer>
  <img src="$sulley" alt="Sulley from Monsters Inc. waving">
  <p class="foot-txt">We can't wait to meet him!</p>
  <p class="foot-names">Hosted with love by Jess &amp; Adriel Waight</p>
</footer>

<script>
  const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  // ── Click-to-Reveal ──
  (function() {
    const overlay = document.getElementById('intro-overlay');
    const heading = document.getElementById('boy-heading');
    const invite = document.getElementById('script-invite');
    const name = document.getElementById('script-name');
    const sulley = document.querySelector('.sulley-hero-svg');
    const scrollHint = document.getElementById('scroll-hint');

    if (!overlay || prefersReducedMotion) {
      document.body.style.overflow = 'auto';
      overlay?.classList.add('hidden');
      heading?.classList.add('revealed');
      invite?.classList.add('reveal-in');
      name?.classList.add('reveal-in');
      sulley?.classList.add('reveal-in');
      return;
    }

    overlay.addEventListener('click', function onClick() {
      overlay.removeEventListener('click', onClick);
      overlay.classList.add('hidden');
      document.body.style.overflow = 'auto';

      setTimeout(() => {
        heading?.classList.add('revealed');
      }, 150);
      setTimeout(() => {
        invite?.classList.add('reveal-in');
      }, 450);
      setTimeout(() => {
        name?.classList.add('reveal-in');
      }, 750);
      setTimeout(() => {
        sulley?.classList.add('reveal-in');
      }, 1050);
      setTimeout(() => {
        if (scrollHint) scrollHint.style.opacity = '1';
      }, 1400);
    });
  })();

  // ── Scroll-driven reveals ──
  (function() {
    if (prefersReducedMotion) {
      document.getElementById('us-sub')?.style.removeProperty('opacity');
      document.getElementById('us-sub')?.style.removeProperty('transform');
      const card = document.getElementById('invite-card');
      if (card) { card.style.removeProperty('opacity'); card.style.removeProperty('transform'); }
      return;
    }
    const bg = document.querySelector('.parallax-bg');
    const sub = document.getElementById('us-sub');
    const card = document.getElementById('invite-card');
    const dets = card ? Array.from(card.querySelectorAll('.det')) : [];
    const decos = Array.from(document.querySelectorAll('.deco'));
    let ticking = false;

    function lerp(a, b, t) { return a + (b - a) * t; }
    function clamp(v, min, max) { return Math.min(max, Math.max(min, v)); }
    function progress(el, dist) {
      if (!el) return 0;
      const rect = el.getBoundingClientRect();
      const wh = window.innerHeight;
      return clamp((wh - rect.top) / (wh * dist), 0, 1);
    }

    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(() => {
          const sy = window.scrollY;
          if (bg) bg.style.transform = 'translateY(' + (sy * 0.08) + 'px)';

          // Section decoration parallax + pop-in
          decos.forEach((d, i) => {
            const rect = d.getBoundingClientRect();
            const vh = window.innerHeight;
            const centerDist = (rect.top + rect.height/2) / vh;
            const rates = [0.18, 0.30, 0.10, 0.25, 0.14];
            const drift = (centerDist - 0.5) * 50 * (rates[i % rates.length]);
            d.style.transform = 'translateY(' + drift + 'px)';
            // Pop in as element enters viewport
            const pop = clamp(1 - (rect.top - vh * 0.85) / (vh * 0.5), 0, 1);
            d.style.opacity = pop * pop;
            d.style.scale = 0.4 + 0.6 * pop;
          });

          // Section 2 — scroll-driven fade
          const pSub = progress(sub, 0.7);
          if (sub) {
            sub.style.opacity = pSub;
            sub.style.transform = 'translateY(' + lerp(20, 0, pSub) + 'px)';
          }

          // Invite card — scroll-driven reveal
          const pCard = progress(card, 0.65);
          if (card) {
            card.style.opacity = pCard;
            card.style.transform = 'translateY(' + lerp(40, 0, pCard) + 'px)';
          }

          // Details — stagger on scroll
          dets.forEach((det, i) => {
            const pDet = clamp((pCard - i * 0.18) / (1 - i * 0.18), 0, 1);
            det.style.opacity = pDet;
            det.style.transform = 'translateY(' + lerp(20, 0, pDet) + 'px)';
            const icon = det.querySelector('.det-icon');
            if (icon && pDet > 0.01) {
              icon.style.transform = 'rotate(' + lerp(-200, 0, pDet) + 'deg) scale(' + lerp(0, 1, pDet) + ')';
              icon.style.opacity = pDet;
            }
          });

          ticking = false;
        });
        ticking = true;
      }
    }, { passive: true });
  })();

  // ── Countdown ──
  (function() {
    function tick() {
      const target = new Date('2026-06-13T13:00:00-06:00');
      const now = new Date();
      const diff = target - now;
      if (diff <= 0) {
        ['cd-d','cd-h','cd-m','cd-s'].forEach(id => {
          const el = document.getElementById(id);
          if (el) el.textContent = '00';
        });
        return;
      }
      const pad = n => String(n).padStart(2,'0');
      const dEl = document.getElementById('cd-d');
      const hEl = document.getElementById('cd-h');
      const mEl = document.getElementById('cd-m');
      const sEl = document.getElementById('cd-s');
      if (dEl) dEl.textContent = pad(Math.floor(diff/86400000));
      if (hEl) hEl.textContent = pad(Math.floor(diff%86400000/3600000));
      if (mEl) mEl.textContent = pad(Math.floor(diff%3600000/60000));
      if (sEl) sEl.textContent = pad(Math.floor(diff%60000/1000));
    }
    tick();
    setInterval(tick, 1000);
  })();
</script>
</body>
</html>
"@

$outPath = Join-Path $folder 'index.html'
[System.IO.File]::WriteAllText($outPath, $html, [System.Text.Encoding]::UTF8)
Write-Output "SUCCESS: index.html written with embedded images"
