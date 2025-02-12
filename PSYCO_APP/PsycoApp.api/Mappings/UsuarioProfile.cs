using AutoMapper;
using PsycoApp.entities.DTO.DtoRequest;
using PsycoApp.entities;

public class UsuarioProfile : Profile
{
    public UsuarioProfile()
    {
        CreateMap<UsuarioLoginDto, Usuario>();
        CreateMap<Usuario, RespuestaUsuario>()
            .ForMember(dest => dest.estado, opt => opt.MapFrom(src => src.validacion == "OK"))
            .ForMember(dest => dest.descripcion, opt => opt.MapFrom(src => src.validacion))
            .ForMember(dest => dest.data, opt => opt.MapFrom(src => src));
    }
}
