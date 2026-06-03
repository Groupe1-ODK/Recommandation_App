<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Inscription – Mon Activité</title>
  <link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;600;700&family=Satoshi:wght@400;500;600&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --navy:  #1a2240;
      --green: #1DB97A;
      --teal:  #3d7a75;
      --teal2: #2f6460;
      --white: #ffffff;
      --gray:  #a8b4cc;
      --light: #f0f2f5;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html, body {
      height: 100%;
      width: 100%;
    }

    body {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--light);
      font-family: 'Satoshi', sans-serif;
    }

    /* ══ CARTE ══ */
    .card {
      display: flex;
      width: min(860px, 94vw);
      border-radius: 24px;
      overflow: hidden;
      box-shadow: 0 20px 60px rgba(26,34,64,0.15), 0 4px 16px rgba(26,34,64,0.08);
      animation: cardIn 0.65s cubic-bezier(0.22,1,0.36,1) both;
    }

    @keyframes cardIn {
      from { opacity: 0; transform: translateY(30px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* ══ PANNEAU GAUCHE ══ */
    .left {
      flex: 1;
      background: var(--white);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 3rem 2rem;
      gap: 2rem;
    }

    /* Logo */
    .logo {
      display: flex;
      align-items: center;
      gap: 12px;
      animation: fadeUp 0.5s 0.2s both;
    }
    .logo-svg  { width: 54px; height: 54px; }
    .logo-text { font-family: 'Clash Display', sans-serif; font-size: 20px; font-weight: 600; color: var(--navy); line-height: 1.25; }
    .logo-text em { color: var(--green); font-style: normal; }

    /* Illustration */
    .illo {
      width: 100%;
      max-width: 260px;
      animation: fadeUp 0.5s 0.32s both;
    }

    /* Tagline */
    .tagline {
      font-size: 13px;
      color: var(--gray);
      text-align: center;
      animation: fadeUp 0.5s 0.42s both;
    }
    .tagline strong { color: var(--navy); font-weight: 600; }

    /* ══ PANNEAU DROIT ══ */
    .right {
      flex: 1.15;
      background: var(--navy);
      padding: 2.6rem 2.4rem;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .form-title {
      font-family: 'Clash Display', sans-serif;
      font-size: 30px;
      font-weight: 700;
      color: var(--white);
      letter-spacing: -0.5px;
      margin-bottom: 10px;
      animation: fadeUp 0.5s 0.28s both;
    }
    .form-subtitle {
      font-size: 13px;
      color: var(--gray);
      margin-bottom: 15px;
      animation: fadeUp 0.5s 0.34s both;
    }
    .form-subtitle span { color: var(--green); }

    /* Séparateur */
    .deco-line {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 1.4rem;
      animation: fadeUp 0.5s 0.38s both;
    }
    .deco-line hr   { flex: 1; border: none; border-top: 1px solid rgba(255,255,255,0.08); }
    .deco-line span { font-size: 10.5px; color: rgba(168,180,204,0.55); letter-spacing: 1px; white-space: nowrap; }

    /* Champs */
    .field { margin-bottom: 0.9rem; animation: fadeUp 0.5s both; }
    .field:nth-child(1) { animation-delay: 0.40s; }
    .field:nth-child(2) { animation-delay: 0.46s; }
    .field:nth-child(3) { animation-delay: 0.52s; }
    .field:nth-child(4) { animation-delay: 0.58s; }

    .field-label {
      display: block;
      font-size: 11px;
      font-weight: 600;
      color: var(--gray);
      letter-spacing: 0.9px;
      text-transform: uppercase;
      margin-bottom: 7px;
      padding-left: 6px;
    }

    .input-wrap { position: relative; }

    .input-icon {
      position: absolute;
      left: 16px; top: 50%;
      transform: translateY(-50%);
      color: #9aa5bc;
      pointer-events: none;
      transition: color 0.2s;
      display: flex;
    }

    .field-input {
      width: 100%;
      background: var(--white);
      border: 2px solid transparent;
      border-radius: 50px;
      padding: 11px 18px 11px 42px;
      font-size: 14px;
      font-family: 'Satoshi', sans-serif;
      color: var(--navy);
      outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    .field-input::placeholder { color: #c0c8d8; font-size: 13px; }
    .field-input:focus {
      border-color: var(--green);
      box-shadow: 0 0 0 3px rgba(29,185,122,0.15);
    }
    .field-input:focus ~ .input-icon { color: var(--green); }

    /* Bouton */
    .btn-submit {
      margin-top: 1.4rem;
      width: 100%;
      background: var(--teal);
      border: none;
      border-radius: 50px;
      padding: 14px 0;
      font-family: 'Clash Display', sans-serif;
      font-size: 15px;
      font-weight: 600;
      color: var(--white);
      cursor: pointer;
      letter-spacing: 0.5px;
      transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
      box-shadow: 0 4px 16px rgba(61,122,117,0.4);
      animation: fadeUp 0.5s 0.66s both;
    }
    .btn-submit:hover  { background: var(--teal2); transform: translateY(-2px); box-shadow: 0 8px 24px rgba(61,122,117,0.45); }
    .btn-submit:active { transform: translateY(0); }

    /* Lien connexion */
    .login-link {
      margin-top: 1rem;
      text-align: center;
      font-size: 13px;
      color: var(--gray);
      animation: fadeUp 0.5s 0.72s both;
    }
    .login-link a { color: var(--green); text-decoration: none; font-weight: 600; }
    .login-link a:hover { text-decoration: underline; }

    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(16px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* Responsive */
    @media (max-width: 640px) {
      .card  { flex-direction: column; }
      .left  { padding: 2rem 1.5rem; }
      .illo  { max-width: 180px; }
      .right { padding: 2rem 1.5rem; }
      .form-title { font-size: 26px; }
    }
    
    .error-box{
    background:#ffebee;
    color:#c62828;
    padding:12px;
    border-radius:10px;
    margin-bottom:15px;
    font-size:14px;
    border-left:4px solid #c62828;
}
  </style>
</head>
<body>

<div class="card">

  <!-- ══ PANNEAU GAUCHE ══ -->
  <div class="left">

   
   
  </div>

  <!-- ══ PANNEAU DROIT ══ -->
  <div class="right">

    <div class="form-title">
        Inscription
    </div>

    <div class="form-subtitle">
        Créez votre compte <span>gratuitement</span>
    </div>

    <% if(request.getAttribute("erreur") != null){ %>

        <div class="error-box">
            <%= request.getAttribute("erreur") %>
        </div>

    <% } %>
    

    <div class="deco-line">
      <hr/><span>INFORMATIONS PERSONNELLES</span><hr/>
    </div>

    <form action="<%=request.getContextPath()%>/inscription"
          method="post">

      <div class="field">
        <label class="field-label" for="nom">Nom</label>
        <div class="input-wrap">
          <input class="field-input" type="text" id="nom" name="nom" placeholder="Entrez votre nom" />
          <span class="input-icon">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
            </svg>
          </span>
        </div>
      </div>

      <div class="field">
        <label class="field-label" for="prenom">Prénom</label>
        <div class="input-wrap">
          <input class="field-input" type="text" id="prenom" name="prenom" placeholder="Entrez votre prénom" />
          <span class="input-icon">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
            </svg>
          </span>
        </div>
      </div>

      <div class="field">
        <label class="field-label" for="telephone">Téléphone</label>
        <div class="input-wrap">
          <input class="field-input" type="tel" id="telephone" name="telephone" placeholder="+223 XX XX XX XX" />
          <span class="input-icon">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.68 3.21a2 2 0 0 1 1.91-2.18h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L7.91 9.91a16 16 0 0 0 6.08 6.08l1.96-1.95a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
            </svg>
          </span>
        </div>
      </div>

      <div class="field">
        <label class="field-label" for="motDePasse">Mot de passe</label>
        <div class="input-wrap">
          <input class="field-input" type="password" id="motDePasse" name="mdp" placeholder="Minimum 8 caractères" />
          <span class="input-icon">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
              <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
            </svg>
          </span>
        </div>
      </div>

      <button type="submit" class="btn-submit">S'inscrire →</button>
    </form>

    <p class="login-link">Déjà inscrit ? <a href="connexion.jsp">Se connecter</a></p>
  </div>
</div>

</body>
</html>
