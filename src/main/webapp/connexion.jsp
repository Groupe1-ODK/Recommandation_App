<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="fr">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Connexion – Mon Activité</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;600;700&family=Satoshi:wght@400;500;600&display=swap"
      rel="stylesheet" />
    <style>
      :root {
        --navy: #1a2240;
        --green: #1DB97A;
        --teal: #3d7a75;
        --teal2: #2f6460;
        --white: #ffffff;
        --gray: #a8b4cc;
        --light: #f0f2f5;
        --error-bg: rgba(255, 80, 80, 0.08);
        --error-border: #ff5050;
        --error-text: #ff6b6b;
        --success-bg: rgba(29, 185, 122, 0.08);
        --success-border: #1DB97A;
        --success-text: #1DB97A;
      }

      *,
      *::before,
      *::after {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }

      html,
      body {
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


      .card {
        display: flex;
        width: min(860px, 94vw);
        border-radius: 24px;
        overflow: hidden;
        box-shadow: 0 20px 60px rgba(26, 34, 64, 0.15), 0 4px 16px rgba(26, 34, 64, 0.08);
        animation: cardIn 0.65s cubic-bezier(0.22, 1, 0.36, 1) both;
      }

      @keyframes cardIn {
        from {
          opacity: 0;
          transform: translateY(30px);
        }

        to {
          opacity: 1;
          transform: translateY(0);
        }
      }


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

      .logo {
        display: flex;
        align-items: center;
        gap: 12px;
        animation: fadeUp 0.5s 0.2s both;
      }

      .logo-svg {
        width: 54px;
        height: 54px;
      }

      .logo-text {
        font-family: 'Clash Display', sans-serif;
        font-size: 20px;
        font-weight: 600;
        color: var(--navy);
        line-height: 1.25;
      }

      .logo-text em {
        color: var(--green);
        font-style: normal;
      }

      .illo {
        width: 100%;
        max-width: 240px;
        animation: fadeUp 0.5s 0.32s both;
      }

      .tagline {
        font-size: 13px;
        color: var(--gray);
        text-align: center;
        animation: fadeUp 0.5s 0.42s both;
      }

      .tagline strong {
        color: var(--navy);
        font-weight: 600;
      }


      .right {
        flex: 1.15;
        background: var(--navy);
        padding: 2.8rem 2.4rem;
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
        margin-bottom: 0.25rem;
        animation: fadeUp 0.5s 0.28s both;
      }

      .form-subtitle {
        font-size: 13px;
        color: var(--gray);
        margin-bottom: 1.4rem;
        animation: fadeUp 0.5s 0.34s both;
      }

      .form-subtitle span {
        color: var(--green);
      }


      .msg-erreur,
      .msg-succes {
        display: flex;
        align-items: center;
        gap: 10px;
        border-radius: 12px;
        border-left-width: 4px;
        border-left-style: solid;
        padding: 11px 16px;
        margin-bottom: 1.2rem;
        font-size: 13px;
        font-weight: 500;
        animation: shake 0.45s cubic-bezier(0.36, 0.07, 0.19, 0.97) both,
          fadeUp 0.4s ease both;
      }

      .msg-erreur {
        background: var(--error-bg);
        border-color: var(--error-border);
        color: var(--error-text);
      }

      .msg-succes {
        background: var(--success-bg);
        border-color: var(--success-border);
        color: var(--success-text);
        animation: fadeUp 0.4s ease both;
      }

      .msg-erreur::before {
        content: '';
        flex-shrink: 0;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        background-color: var(--error-border);
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 24 24' fill='none' stroke='white' stroke-width='3' stroke-linecap='round' stroke-linejoin='round'%3E%3Cline x1='18' y1='6' x2='6' y2='18'/%3E%3Cline x1='6' y1='6' x2='18' y2='18'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: center;
      }

      .msg-succes::before {
        content: '';
        flex-shrink: 0;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        background-color: var(--success-border);
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 24 24' fill='none' stroke='white' stroke-width='3' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='20 6 9 17 4 12'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: center;
      }

      @keyframes shake {

        10%,
        90% {
          transform: translateX(-2px);
        }

        20%,
        80% {
          transform: translateX(4px);
        }

        30%,
        50%,
        70% {
          transform: translateX(-4px);
        }

        40%,
        60% {
          transform: translateX(4px);
        }
      }


      .deco-line {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 1.4rem;
        animation: fadeUp 0.5s 0.38s both;
      }

      .deco-line hr {
        flex: 1;
        border: none;
        border-top: 1px solid rgba(255, 255, 255, 0.08);
      }

      .deco-line span {
        font-size: 10.5px;
        color: rgba(168, 180, 204, 0.55);
        letter-spacing: 1px;
        white-space: nowrap;
      }


      .field {
        margin-bottom: 1rem;
        animation: fadeUp 0.5s both;
      }

      .field:nth-child(1) {
        animation-delay: 0.40s;
      }

      .field:nth-child(2) {
        animation-delay: 0.48s;
      }

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

      .input-wrap {
        position: relative;
      }

      .input-icon {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: #9aa5bc;
        pointer-events: none;
        transition: color 0.2s;
        display: flex;
      }


      .eye-toggle {
        position: absolute;
        right: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: #9aa5bc;
        cursor: pointer;
        background: none;
        border: none;
        padding: 0;
        display: flex;
        transition: color 0.2s;
      }

      .eye-toggle:hover {
        color: var(--green);
      }

      .field-input {
        width: 100%;
        background: var(--white);
        border: 2px solid transparent;
        border-radius: 50px;
        padding: 11px 44px 11px 42px;
        font-size: 14px;
        font-family: 'Satoshi', sans-serif;
        color: var(--navy);
        outline: none;
        transition: border-color 0.2s, box-shadow 0.2s;
      }

      .field-input::placeholder {
        color: #c0c8d8;
        font-size: 13px;
      }

      .field-input:focus {
        border-color: var(--green);
        box-shadow: 0 0 0 3px rgba(29, 185, 122, 0.15);
      }

      .field-input:focus~.input-icon {
        color: var(--green);
      }


      .forgot {
        text-align: right;
        margin-top: 6px;
        padding-right: 6px;
        animation: fadeUp 0.5s 0.54s both;
      }

      .forgot a {
        font-size: 12px;
        color: var(--gray);
        text-decoration: none;
        transition: color 0.2s;
      }

      .forgot a:hover {
        color: var(--green);
      }


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
        box-shadow: 0 4px 16px rgba(61, 122, 117, 0.4);
        animation: fadeUp 0.5s 0.60s both;
      }

      .btn-submit:hover {
        background: var(--teal2);
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(61, 122, 117, 0.45);
      }

      .btn-submit:active {
        transform: translateY(0);
      }

      .register-link {
        margin-top: 1rem;
        text-align: center;
        font-size: 13px;
        color: var(--gray);
        animation: fadeUp 0.5s 0.68s both;
      }

      .register-link a {
        color: var(--green);
        text-decoration: none;
        font-weight: 600;
      }

      .register-link a:hover {
        text-decoration: underline;
      }

      @keyframes fadeUp {
        from {
          opacity: 0;
          transform: translateY(16px);
        }

        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      @media (max-width: 640px) {
        .card {
          flex-direction: column;
        }

        .left {
          padding: 2rem 1.5rem;
        }

        .illo {
          max-width: 160px;
        }

        .right {
          padding: 2rem 1.5rem;
        }

        .form-title {
          font-size: 26px;
        }
      }
    </style>
  </head>

  <body>

    <div class="card">


      <div class="left">


      </div>


      <div class="right">

        <div class="form-title">Connexion</div>
        <p class="form-subtitle">Accédez à <span>votre tableau de bord</span></p>

        <%-- ── Message erreur serveur ── --%>
          <% if (request.getAttribute("erreur") !=null) { %>
            <div class="msg-erreur">
              <%= request.getAttribute("erreur") %>
            </div>
            <% } %>

              <%-- ── Message succès (ex: après inscription) ── --%>
                <% if (request.getParameter("inscription") !=null &&
                  request.getParameter("inscription").equals("succes")) { %>
                  <div class="msg-succes">
                    Inscription réussie ! Vous pouvez vous connecter.
                  </div>
                  <% } %>

                    <div class="deco-line">
                      <hr /><span>VOS IDENTIFIANTS</span>
                      <hr />
                    </div>

                    <form action="<%= request.getContextPath() %>/connexion" method="post">

                      <div class="field">
                        <label class="field-label" for="telephone">Téléphone</label>
                        <div class="input-wrap">
                          <input class="field-input" type="tel" id="telephone" name="telephone"
                            value="<%= request.getParameter(" telephone") !=null ? request.getParameter("telephone")
                            : "" %>"
                          placeholder="+223 XX XX XX XX" required/>
                          <span class="input-icon">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                              stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                              <path
                                d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.68 3.21a2 2 0 0 1 1.91-2.18h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L7.91 9.91a16 16 0 0 0 6.08 6.08l1.96-1.95a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" />
                            </svg>
                          </span>
                        </div>
                      </div>

                      <div class="field">
                        <label class="field-label" for="motDePasse">Mot de passe</label>
                        <div class="input-wrap">
                          <input class="field-input" type="password" id="motDePasse" name="mdp"
                            placeholder="Votre mot de passe" />
                          <span class="input-icon">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                              stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                              <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                              <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                          </span>

                          <button type="button" class="eye-toggle" onclick="toggleMdp(this)"
                            aria-label="Afficher le mot de passe">
                            <svg id="eye-icon" width="16" height="16" viewBox="0 0 24 24" fill="none"
                              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                              <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                              <circle cx="12" cy="12" r="3" />
                            </svg>
                          </button>
                        </div>
                      </div>

                      <div class="forgot">
                        <a href="motDePasseOublie.jsp">Mot de passe oublié ?</a>
                      </div>

                      <button type="submit" class="btn-submit">Se connecter →</button>
                    </form>

                    <p class="register-link">Pas encore de compte ? <a href="inscription.jsp">S'inscrire</a></p>
      </div>
    </div>

    <script>
      function toggleMdp(btn) {
        var input = document.getElementById('motDePasse');
        var icon = btn.querySelector('svg');
        if (input.type === 'password') {
          input.type = 'text';
          icon.innerHTML = '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/>';
        } else {
          input.type = 'password';
          icon.innerHTML = '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';
        }
      }
    </script>

  </body>

  </html>