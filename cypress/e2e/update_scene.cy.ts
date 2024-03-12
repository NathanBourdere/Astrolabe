describe('template spec', () => {
  it('update scene', () => {
    cy.visit('/')

    // cliquer sur la balise a qui a pour href "#collapseArtistes"
    cy.get('a[href="#collapseScenes"]').click()

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/artistes/1"
    cy.get('a[href="/festivals/scenes/1"]').click();

    // Attendre que la page des artistes se charge
    cy.url().should('include', '/festivals/scenes/1');

    // récupère la dernière div avec la classe 
    const div = cy.get('div.col').last();

    // récupérer la seconde balise a dans la div et cliquer dessus
    div.find('a').click();

    // récupère l'url
    const url = cy.url();

    //on clique sur le bouton modifier
    cy.get('a[class="btn btn-warning"]').click()

    //on clear l'input
    cy.get('input[name="nom"]').clear()

    // Chercher le input "Nom" et rempli le avec des caractères aléatoires
    cy.get('input[name="nom"]').type('UpdateScene' + Math.floor(Math.random() * 1000000));

    //on clear l'input
    cy.get('input[name="lieu"]').clear()

    // Chercher le input "Lieu" et rempli le avec des caractères aléatoires
    cy.get('input[name="lieu"]').type('UpdateLieu' + Math.floor(Math.random() * 1000000));

    // Valider le formulaire
    cy.get('input[value="Enregistrer"]').click();
  })
})