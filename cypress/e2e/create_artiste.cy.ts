describe('template spec', () => {
  it('create new artiste', () => {
    cy.visit('/')

    // cliquer sur la balise a qui a pour href "#collapseArtistes"
    cy.get('a[href="#collapseArtistes"]').click()

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/artistes/create"
    cy.get('a[href="/festivals/artistes/create"]').click();

    // Attendre que la page de création d'artiste se charge
    cy.url().should('include', '/festivals/artistes/create');

    // Chercher le input "Nom" et rempli le avec des caractères aléatoires
    cy.get('input[name="nom"]').type('Artiste' + Math.floor(Math.random() * 1000000));

    // Chercher le textarea "Description" et rempli le avec des caractères aléatoires
    cy.get('textarea[name="description"]').type('Description' + Math.floor(Math.random() * 1000000));

    // Valider le formulaire
    cy.get('input[value="Enregistrer"]').click();
  })
})