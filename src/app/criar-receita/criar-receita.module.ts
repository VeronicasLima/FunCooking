import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular/lazy';

import { CriarReceitaPageRoutingModule } from './criar-receita-routing.module';

import { CriarReceitaPage } from './criar-receita.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    CriarReceitaPageRoutingModule
  ],
  declarations: [CriarReceitaPage]
})
export class CriarReceitaPageModule {}
