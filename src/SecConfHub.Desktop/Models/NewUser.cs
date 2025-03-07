using Microsoft.EntityFrameworkCore.Storage.ValueConversion.Internal;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace SecConfHub.Desktop.Models
{
    public class NewUser
    {
        public int Id { get; set; }

        [Required]
        public string FullName { get; set; } = null!;

        [AllowedValues("мужской", "женский")]
        public string Gender { get; set; } = null!;

        [AllowedValues("moderator", "jury")]
        public string Role { get; set; } = null!;

        [Required]
        [EmailAddress]
        public string Email { get; set; } = null!;

        [Required]
        [Phone]
        public string Phone { get; set; } = null!;

        [Required]
        public string ActivityDirection { get; set; } = null!;

        [Required]
        [RegularExpression(@"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_])[\w!@#$%^&*()\-+=<>?/{}[\]~]{6,}$", 
            ErrorMessage = "Пароль не мнее 6 символов Заглавные и строчные буквы. Не менее одного спецсимвола. Не менее одной цифры.")]
        public string Password { get; set; } = null!;

        [Required]
        [Compare(nameof(Password))]
        public string ConfirmPassword { get; set; } = null!;
    }
}
