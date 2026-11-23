import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'welcome',
    pathMatch: 'full'
  },

  {
    path: 'welcome',
    loadChildren: () =>
      import('./welcome/welcome.module')
        .then(m => m.WelcomePageModule)
  },

  {
    path: 'login',
    loadChildren: () => import('./login/login.module').then( m => m.LoginPageModule)
  },

  {
    path: 'register',
    loadChildren: () => import('./register/register.module').then( m => m.RegisterPageModule)
  },

  {
    path: 'administrador',
    loadChildren: () => import('./administrador/administrador.module').then( m => m.AdministradorPageModule)
  },
  {
    path: 'gerir-utilizadores',
    loadChildren: () => import('./gerir-utilizadores/gerir-utilizadores.module').then( m => m.GerirUtilizadoresPageModule)
  },
  {
    path: 'tabs',
    loadChildren: () => import('./tabs/tabs.module').then( m => m.TabsPageModule)
  },
  {
    path: 'receitas',
    loadChildren: () => import('./receitas/receitas.module').then( m => m.ReceitasPageModule)
  },
  {
    path: 'criar-receita',
    loadChildren: () => import('./criar-receita/criar-receita.module').then( m => m.CriarReceitaPageModule)
  },

];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      preloadingStrategy: PreloadAllModules
    })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}
