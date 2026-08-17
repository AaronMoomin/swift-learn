

import SwiftUI

struct RegisterForm {
    enum Plan: String, CaseIterable, Identifiable {
        case free = "免费"
        case pro = "专业"

        var id: Self { self }
    }
    
    var email = ""
    var password = ""
    var plan: Plan = .free
    var birthday = Date()
    var volume = 50.0
    
     var isValidEmail: Bool {
        email.contains("@") && email.contains(".")
    }
     var isValidPassword: Bool {
        password.count >= 8
    }
     var isValid: Bool {
        isValidEmail && isValidPassword
    }
    
}

struct FormView: View {
    @State private var form = RegisterForm()
    @State private var isSubmit = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("邮箱", text: $form.email)
                    .textContentType(.emailAddress)
                if isSubmit && !form.isValidEmail {
                    Text("输入有效邮箱")
                        .foregroundStyle(.red)
                }
                SecureField("密码", text: $form.password)
                    .textContentType(.password)
                if isSubmit && !form.isValidPassword {
                    Text("密码至少需要8位")
                        .foregroundStyle(.red)
                }
                Picker("套餐", selection: $form.plan) {
                    ForEach(RegisterForm.Plan.allCases) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                DatePicker("生日", selection: $form.birthday, in: ...Date(),displayedComponents:.date)
                    
                HStack {
                    Text("音量")
                    Slider(value: $form.volume, in: 0...100, step: 1) {
                        Text("音量")
                    } minimumValueLabel: {
                        Image(systemName: "speaker.fill")
                    } maximumValueLabel: {
                        Image(systemName: "speaker.wave.3.fill")
                    }
                }
                
                HStack(spacing: 12) {
                    Button {
                        isSubmit = false
                        form = RegisterForm()
                    } label: {
                        Text("取消")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        isSubmit = true
                        guard form.isValid else {return}
                        submit(form)
                    } label: {
                        Text("提交")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("注册")
        }
       
    }
        
    private func submit(_ form: RegisterForm) {
        print(form.email, form.plan.rawValue)
    }
}

#Preview {
    FormView()
}
