using ColorTypes
using ColorTypes.FixedPointNumbers
using Test
#=
function _AGray32(val::Real, alpha = 1)
    #ColorTypes.checkval(AGray32, val, alpha)
    AGray32(val%N0f8, alpha%N0f8)
end
function _AGray32(g::Gray24, alpha=1)
    #ColorTypes.checkval(AGray32, alpha)
    reinterpret(AGray32, UInt32(reinterpret(ColorTypes._rem(alpha, N0f8))) << 24 | g.color)
end
_AGray32(g::AbstractGray, alpha = 1) = _AGray32(gray(g), alpha)
=#


#=
@show _AGray32(Gray24(0.2), 0.8)
@show AGray32(Gray24(0.2), 0.8)

@show _AGray32(Gray24(0.2), 0.8f0)
@show AGray32(Gray24(0.2), 0.8f0)

@show _AGray32(Gray24(0.2), Float16(0.8))
@show AGray32(Gray24(0.2), Float16(0.8))


function f(t::Tuple)
    result = UInt32(0)
    for val in t
        result |= _AGray32(val, 0.8).color
    end
    return result
end

function fshow(t::Tuple)
    for val in t
        @show _AGray32(val, 0.8).color
    end
end

@info "f((Gray24(0.2), Gray24(0.2))"
@show f((Gray24(0.2), Gray24(0.2)))

@info "f((Gray24(0.2), Gray{N0f8}(0.2))"
@show f((Gray24(0.2), Gray{N0f8}(0.2)))

@info "fshow((Gray24(0.2), Gray24(0.2))"
fshow((Gray24(0.2), Gray24(0.2)))

@info "fshow((Gray24(0.2), Gray{N0f8}(0.2))"
fshow((Gray24(0.2), Gray{N0f8}(0.2)))
=#

signedtype(::Type{T}) where {T<:Integer} = typeof(signed(zero(T)))

function _unsafe_trunc(::Type{T}, x::AbstractFloat) where {T<:Integer}
    unsafe_trunc(T, unsafe_trunc(signedtype(T), x))
end

function normed8(value)
    _unsafe_trunc(UInt8, value * 255.0f0)
end

function _beta(g::AbstractGray, alpha)
    UInt32(normed8(alpha)) # conversion to UInt32 is a key point
end
function _beta(g::Gray24, alpha)
    UInt32(normed8(alpha))
end

function print_beta(t)
    for val in t
        println(_beta(val, 0.8))
    end
end

@info "print_beta((Gray24(0.2), Gray24(0.2)))"
print_beta((Gray24(0.2), Gray24(0.2)))

@info "print_beta((Gray24(0.2), Gray{N0f8}(0.2)))"
print_beta((Gray24(0.2), Gray{N0f8}(0.2)))

@info "print_beta((Gray{N0f8}(0.2), Gray24(0.2)))"
print_beta((Gray{N0f8}(0.2), Gray24(0.2)))

@info "print_beta((Gray{N0f8}(0.2), Gray{N0f8}(0.2)))"
print_beta((Gray{N0f8}(0.2), Gray{N0f8}(0.2)))

@info "print_beta([Gray{N0f8}(0.2), Gray24(0.2)])"
print_beta([Gray{N0f8}(0.2), Gray24(0.2)])

#=
function _alpha(g::AbstractGray, alpha)
    UInt32(reinterpret(alpha % N0f8))
end
function _alpha(g::Gray24, alpha)
    UInt32(reinterpret(alpha % N0f8))
end

function gshow(t::Tuple)
    for val in t
        println(_alpha(val, 0.8))
    end
end

@info "gshow((Gray24(0.2), Gray24(0.2)))"
gshow((Gray24(0.2), Gray24(0.2)))

@info "gshow((Gray24(0.2), Gray{N0f8}(0.2)))"
gshow((Gray24(0.2), Gray{N0f8}(0.2)))

@info "gshow((Gray{N0f8}(0.2), Gray24(0.2)))"
gshow((Gray{N0f8}(0.2), Gray24(0.2)))

@info "gshow((Gray{N0f8}(0.2), Gray{N0f8}(0.2)))"
gshow((Gray{N0f8}(0.2), Gray{N0f8}(0.2)))
=#




#=
@info "for val in (Gray{N0f8}(0.2), Gray{N0f8}(0.2))"
for val in (Gray{N0f8}(0.2), Gray{N0f8}(0.2))
    @show val, _AGray32(val, 0.8), _AGray32(val, 0.8).color
end

@info "for val in (Gray24(0.2), Gray24(0.2))"
for val in (Gray24(0.2), Gray24(0.2))
    @show val, _AGray32(val, 0.8), _AGray32(val, 0.8).color
end

@info "for val in (Gray24(0.2), Gray{N0f8}(0.2))"
for val in (Gray24(0.2), Gray{N0f8}(0.2))
    @show val, _AGray32(val, 0.8), _AGray32(val, 0.8).color
end

@info "for val in (Gray{N0f8}(0.2), Gray24(0.2))"
for val in (Gray{N0f8}(0.2), Gray24(0.2))
    @show val, _AGray32(val, 0.8), _AGray32(val, 0.8).color
end

@info "for val in (Gray{N0f8}(0.2), Gray24(0.2))"
for val in (Gray{N0f8}(0.2), Gray24(0.2))
    @show val, AGray32(val, 0.8), AGray32(val, 0.8).color
    @show which(AGray32, Tuple{typeof(val),Float64})
end
=#