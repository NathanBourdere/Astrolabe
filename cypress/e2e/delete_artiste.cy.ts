describe('template spec', () => {
  it('delete artiste', () => {
    cy.visit('/')

    // cliquer sur la balise a qui a pour href "#collapseArtistes"
    cy.get('a[href="#collapseArtistes"]').click()

    // Cliquer sur la balise <a> redirigeant vers href="/festivals/artistes/1"
    cy.get('a[href="/festivals/artistes/1"]').click();

    // Attendre que la page des artistes se charge
    cy.url().should('include', '/festivals/artistes/1');

    // récupère la dernière div avec la classe "col-12 col-sm-6 col-md-4 col-lg-3"
    const div = cy.get('div.col-12.col-sm-6.col-md-4.col-lg-3').last();

    // récupérer la seconde balise a dans la div et cliquer dessus
    div.find('a').eq(1).click();

    // récupère l'url
    const url = cy.url();


  })
})