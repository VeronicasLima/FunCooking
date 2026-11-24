import { ComponentFixture, TestBed } from '@angular/core/testing';
import { GerirUtilizadoresPage } from './gerir-utilizadores.page';

describe('GerirUtilizadoresPage', () => {
  let component: GerirUtilizadoresPage;
  let fixture: ComponentFixture<GerirUtilizadoresPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(GerirUtilizadoresPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
