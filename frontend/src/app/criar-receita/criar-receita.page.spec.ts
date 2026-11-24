import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CriarReceitaPage } from './criar-receita.page';

describe('CriarReceitaPage', () => {
  let component: CriarReceitaPage;
  let fixture: ComponentFixture<CriarReceitaPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(CriarReceitaPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
