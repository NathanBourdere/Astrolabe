describe('template spec', () => {
  it('delete scene', () => {
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

    //on click sur supprimer
    cy.get('a[class="btn btn-danger"]').click()

    //confirme notre choix 
    cy.get('button.btn.btn-danger.rounded-pill a').click();
  })
})