
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
  standalone: false
})
export class LoginPage implements OnInit {

  loginForm!: FormGroup;
  loginError: string = '';

  constructor(private formBuilder: FormBuilder) {}

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

    this.loginError =
      'Autenticação ainda não disponível.';

  }
}
