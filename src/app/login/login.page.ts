import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient,HttpErrorResponse } from '@angular/common/http';
import {Router} from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
  standalone: false
})

export class LoginPage implements OnInit {

  loginForm!: FormGroup;
  loginError: string = '';
  isLoading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private http: HttpClient,
    private router: Router
  ) {}

  ngOnInit() {

    this.loginForm = this.formBuilder.group({
      email: ['', [
        Validators.required,
        Validators.email
      ]],
      password: ['', [
        Validators.required,
        Validators.minLength(6)
      ]]
    });

    this.loginForm.valueChanges.subscribe(() => {
      this.loginError = '';
    });
  }

  login() {

    this.loginError = '';

    if (this.loginForm.invalid) {
      this.loginForm.markAllAsTouched();
      this.loginError =
        'Verifica o email e a palavra-passe introduzidos.';
      return;
    }

    if (this.isLoading) {
      return;
    }

    this.isLoading = true;

    this.http.post<{
      mensagem: String;
      utilizador: {
        id_utilizador: String;
        nome: string;
        email:string;
        tipo_utilizador:string;
      };
    }>(
      'http://localhost:3000/login',
      this.loginForm.value
    ).subscribe({

      next: (resposta) => {
        this.isLoading = false;

        if (resposta.utilizador.tipo_utilizador == 'administrador'){
          this.router.navigate(['/administrador']);
        } else {
          this.router.navigate(['/tabs/inicio']);
        }
      },

      error: (erro: HttpErrorResponse) => {
        this.isLoading = false;

        this.loginError =
        erro.error?.mensagem || 'Não foi possível iniciar sessão. Tente novamente. ';
      }
    });
  }
}

