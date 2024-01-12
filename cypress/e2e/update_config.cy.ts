describe('template spec', () => {
  it('changes configuration', () => {
    // Visiter la page d'accueil
    cy.visit('/');

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/configuration/"
    cy.get('a[href="/festivals/configuration/"]').click();

    // Attendre que la page de configuration se charge (ajuster le sélecteur au besoin)
    cy.url().should('include', '/festivals/configuration');

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/configuration/update"
    cy.get('a[href="/festivals/configuration/update"]').click();

    // Attendre que la page de mise à jour de la configuration se charge (ajuster le sélecteur au besoin)
    cy.url().should('include', '/festivals/configuration/update');

    // retire le texte de la balise <input> pour éviter les erreurs de validation
    cy.get('input[name="couleur_background"]').clear();

    // créer une couleur aléatoire
    const randomColor = Math.floor(Math.random() * 16777215).toString(16);

    // Remplir le champ "Couleur background" avec la couleur
    cy.get('input[name="couleur_background"]').type('#' + randomColor);

    // Cliquer sur le bouton "Enregistrer" qui a pour value "Enregistrer"
    cy.get('input[value="Enregistrer"]').click();

    // Attendre que la page de configuration se charge (ajuster le sélecteur au besoin)
    cy.url().should('include', '/festivals/configuration');

    // Vérifier que la couleur de fond est bien celle qui a été saisie
    // je récupère tous les tr avec la classe table-light
    const trs = cy.get('tr.table-light');

    // dans chaque tr, je récupère le th qui a pour texte "Couleur de fond"
    const th = trs.find('th:contains("Couleur de fond")');

    // je récupère le td suivant celui qui a pour texte "Couleur de fond"
    const td = th.next();

    // je récupère le texte du td
    const tdText = td.invoke('text');

    // je vérifie que le texte du td est bien la couleur saisie
    tdText.should('eq', '#' + randomColor);
  });
});
