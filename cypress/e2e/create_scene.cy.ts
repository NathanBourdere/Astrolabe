describe('template spec', () => {
  it('create new scene', () => {
    cy.visit('/')
    
    //cliquer sur la balise qui a pour href= collapsScenes
    cy.get('a[href="#collapseScenes"]').click()

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/scenes/create"
    cy.get('a[href="/festivals/scenes/create"]').click();

      // Attendre que la page de création de scene se charge
      cy.url().should('include', '/festivals/scenes/create');


    // Chercher le input "Nom" et rempli le avec des caractères aléatoires
    cy.get('input[name="nom"]').type('Scene' + Math.floor(Math.random() * 1000000));


    // Chercher le input "Lieu" et rempli le avec des caractères aléatoires
    cy.get('input[name="lieu"]').type('Lieu' + Math.floor(Math.random() * 1000000));

    // Valider le formulaire
    cy.get('input[value="Enregistrer"]').click();
  })
})

