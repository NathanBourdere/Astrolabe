describe('Tests E2E Artistes', () => {
  it('Nouvel Artiste', () => {
    cy.visit('/')

    // cliquer sur la balise a qui a pour href "#collapseArtistes"
    cy.get('a[href="#collapseArtistes"]').click()

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/artistes/create"
    cy.get('a[href="/festivals/artistes/create"]').click();

    // Attendre que la page de création d'artiste se charge
    cy.url().should('include', '/festivals/artistes/create');

    // Chercher le input "Nom" et rempli le champ
    cy.get('input[name="nom"]').type('Test');

    // Chercher le textarea "Description" et rempli le avec des caractères aléatoires
    cy.get('textarea[name="description"]').type('TestDescription');

    // Valider le formulaire
    cy.get('input[value="Enregistrer"]').click();
  })

  it('Mise a jour artiste', () => {
    cy.visit('/')

    // cliquer sur la balise a qui a pour href "#collapseArtistes"
    cy.get('a[href="#collapseArtistes"]').click()

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/artistes/1"
    cy.get('a[href="/festivals/artistes/1"]').click();

    // Attendre que la page des artistes se charge
    cy.url().should('include', '/festivals/artistes/1');

    // Récupère l'artiste Test créé précédemment
    cy.get('h3').contains('Test').click();

    // Cliquer sur le bouton de modification
    cy.get('a[class="btn btn-warning"]').click();

    // Chercher le input "Nom" et rempli le champ
    cy.get('input[name="nom"]').clear().type('Test2');

    // Chercher le textarea "Description" et le remplir
    cy.get('textarea[name="description"]').clear().type('TestDescription2');

    // Chercher le input "Site Web" et le remplir
    cy.get('input[id="id_site_web"]').clear().type('https://www.test.com');

    // Chercher le id "Youtube" et le remplir
    cy.get('input[id="id_youtube"]').clear().type('https://www.youtube.com');

    // Chercher le id "Instagram" et le remplir
    cy.get('input[id="id_instagram"]').clear().type('https://www.instagram.com');

    // Chercher le id "Facebook" et le remplir
    cy.get('input[id="id_facebook"]').clear().type('https://www.facebook.com');

    // Sélectionner des recommandations
    cy.get('input[id="id_recommendations_3"]').click();
    cy.get('input[id="id_recommendations_4"]').click();

    // Valider le formulaire
    cy.get('input[value="Enregistrer"]').click();
  })

  it('Lecture artiste', () => {
    cy.visit('/');

    // Cliquer sur la balise a qui a pour href "#collapseArtistes"
    cy.get('a[href="#collapseArtistes"]').click();

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/artistes/1"
    cy.get('a[href="/festivals/artistes/1"]').click();

    // Attendre que la page des artistes se charge
    cy.url().should('include', '/festivals/artistes/1');

    // Récupère l'artiste Test créé précédemment
    cy.contains('h3', 'Test2').click();

    // Vérifier que le nom est correct
    cy.get('h4').contains('Test2');

    // Vérifier que la description est correcte
    cy.get('p').contains('TestDescription2');

    // Vérifier que les informations sont correctes
    cy.get('.table-bordered tbody').within(() => {
      cy.contains('Site Web').next('td').should('contain.text', 'https://www.test.com');
      cy.contains('Youtube').next('td').should('contain.text', 'https://www.youtube.com');
      cy.contains('Instagram').next('td').should('contain.text', 'https://www.instagram.com');
      cy.contains('Facebook').next('td').should('contain.text', 'https://www.facebook.com');

      // Verifier la source de l'image
      cy.contains('Image de fond').next('td').find('img').should('have.attr', 'src', '/static/media/artistes/default.jpg');

      // Verifier les recommandations
      cy.contains('Recommendations').next('td').should('contain.text', 'Slayer');
      cy.contains('Recommendations').next('td').should('contain.text', 'Cannibal Corpse');
    }
    );
  }
  );

  it('Suppression Artiste', () => {
    cy.visit('/')

    // cliquer sur la balise a qui a pour href "#collapseArtistes"
    cy.get('a[href="#collapseArtistes"]').click()

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/artistes/1"
    cy.get('a[href="/festivals/artistes/1"]').click();

    // Attendre que la page des artistes se charge
    cy.url().should('include', '/festivals/artistes/1');

    // Récupère l'artiste Test créé précédemment
    cy.get('h3').contains('Test').click();

    // Cliquer sur le bouton de suppression
    cy.get('a[class="btn btn-danger"]').click();

    // Attendre que la modal apparaisse
    cy.wait(2000);

    // Récupérer le bouton de suppression et cliquer dessus
    cy.get('button[class="btn btn-danger rounded-pill"]').contains('Supprimer Test').click();
  })
})
export {};